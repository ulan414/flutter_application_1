import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPhoto extends StatefulWidget {
  const MyPhoto({super.key});

  @override
  State<MyPhoto> createState() => _MyPhotoState();
}

class _MyPhotoState extends State<MyPhoto> {
  // Store up to 6 images. Null means the slot is empty.
  List<File?> selectedImages = List.generate(6, (index) => null);
  final ImagePicker _picker = ImagePicker();

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
      backgroundColor: const Color(0xFF2D262B), // Dark background from your image
      body: Stack(
        children: [
          // Background assets... (keep your existing Stack setup)
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
                  
                  // --- PHOTO GRID START ---
                  _buildPhotoGrid(),
                  
                  const Spacer(),
                  SizedBox(
                  width: 350,
                  height: 56,
                  child: Material( // Added Material for InkWell splash to show
                    color: const Color(0xFFE93C35),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: const Center(
                        child: Text(
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
      height: 400, // Fixed height for the grid area
      child: Row(
        children: [
          // Left side: The Large Image (Slot 0)
          Expanded(
            flex: 2,
            child: _buildPhotoSlot(0, isLarge: true),
          ),
          const SizedBox(width: 10),
          // Right side: Two smaller images (Slots 1 and 2)
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
    // Note: To match your image exactly, you'd add another Row 
    // below this one for slots 3, 4, and 5.
  }

  // Helper for individual slots
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
    return Container(
      width: 280, height: 8,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: const Color(0xFFFFE9F1), borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 280 / 8 * 8, height: 8,
        decoration: BoxDecoration(color: const Color(0xFFE93C35), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}