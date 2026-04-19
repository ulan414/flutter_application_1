import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';
import 'my_gender.dart';

class MyAge extends StatefulWidget {
  const MyAge({super.key});
    @override
  State<MyAge> createState() => _MyAgeState();
}
class _MyAgeState extends State<MyAge> {
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Layer
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. UI Layer
          SafeArea(
            child: SizedBox.expand( // Ensures the Column spans the full width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20), // Top padding

                  // --- 1. PROGRESS BAR (TOP) ---
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // Общий отступ для всей строки
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center, // Выравнивание по центру высоты
                        children: [
                          // Кнопка назад
                          IconButton(
                            padding: EdgeInsets.zero, // Убираем внутренний отступ иконки
                            constraints: const BoxConstraints(), // Убираем минимальный размер 48x48
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          
                          const SizedBox(width: 15), // Отступ между стрелкой и прогресс-баром

                          // Progress Bar
                          Expanded( // Используем Expanded, чтобы бар занял оставшееся место, либо оставьте Container с фиксированной шириной
                            child: Container(
                              height: 8,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE9F1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 3 / 8, // Пропорция заполнения (3 из 8 шагов)
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE93C35),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20), // Небольшой отступ справа для симметрии
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --- 2. LOGO ---
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 50), // Space between logo and text

                  // --- 3. TEXT ---
                  const Text(
                    "Сколько вам лет?",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: TextField(
                      controller: _ageController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "18", // This shows when the field is empty
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Left alignment spacing
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none, // Removes the default underline/border
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                  width: 350,
                  height: 56,
                  child: Material( // Added Material for InkWell splash to show
                    color: const Color(0xFFE93C35),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        final ageText = _ageController.text.trim();

                        if (ageText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Введите возраст"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final age = int.tryParse(ageText);

                        if (age == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Введите корректный возраст"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (age < 18) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Вам должно быть не менее 18 лет"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (age > 99) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Введите реальный возраст"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        context.read<RegistrationProvider>().setAge(age);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyGender()),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}