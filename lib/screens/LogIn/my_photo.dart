import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/registration_provider.dart';
import 'package:flutter_application_1/screens/App/Search.dart';

class MyPhoto extends StatefulWidget {
  const MyPhoto({super.key});

  @override
  State<MyPhoto> createState() => _MyPhotoState();
}

class _MyPhotoState extends State<MyPhoto> {
  List<File?> selectedImages = List.generate(6, (index) => null);
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;  // добавил

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImages[index] = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D262B),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProgressBar(),
                  const SizedBox(height: 40),
                  const Text(
                    "Upload Your Photo",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  _buildPhotoGrid(),
                  const Spacer(),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: Material(
                      color: const Color(0xFFE93C35),
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: _isLoading ? null : () async {
                          setState(() => _isLoading = true);

                          try {
                            final supabase = Supabase.instance.client;
                            final List<String> photoUrls = [];

                            // 1. Загружаем фото в Supabase Storage
                            for (int i = 0; i < selectedImages.length; i++) {
                              if (selectedImages[i] != null) {
                                final file = selectedImages[i]!;
                                final fileName = 'photos/${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

                                await supabase.storage
                                    .from('user-photos')
                                    .upload(fileName, file);

                                final url = supabase.storage
                                    .from('user-photos')
                                    .getPublicUrl(fileName);

                                photoUrls.add(url);
                              }
                            }

                            // 2. Сохраняем урлы в провайдер
                            if (mounted) {
                              context.read<RegistrationProvider>().setPhotos(photoUrls);

                              // 3. Загружаем всё в базу
                              await context.read<RegistrationProvider>().saveToSupabase();

                              // 4. Переходим на главный экран
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Search()),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Ошибка: $e"), backgroundColor: Colors.red),
                              );
                            }
                          } finally {
                            if (mounted) setState(() => _isLoading = false);
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Ready?",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return SizedBox(
      height: 400,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildPhotoSlot(0, isLarge: true),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _buildPhotoSlot(1)),
                const SizedBox(height: 10),
                Expanded(child: _buildPhotoSlot(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSlot(int index, {bool isLarge = false}) {
    File? image = selectedImages[index];

    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          image: image != null
              ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? Center(
                child: Icon(
                  Icons.add_circle,
                  color: const Color(0xFFE93C35),
                  size: isLarge ? 40 : 30,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildProgressBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                height: 8,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FractionallySizedBox(
                  widthFactor: 8 / 8,  // последний шаг — полный бар
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE93C35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}