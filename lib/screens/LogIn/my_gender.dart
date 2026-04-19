import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';
import 'i_am_looking.dart';

class MyGender extends StatefulWidget {  // StatelessWidget -> StatefulWidget
  const MyGender({super.key});

  @override
  State<MyGender> createState() => _MyGenderState();
}

class _MyGenderState extends State<MyGender> {
  String? _selectedGender;  // добавил

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SafeArea(
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
                                widthFactor: 3 / 8,
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
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/imgs/logo.png', width: 200, fit: BoxFit.contain),
                  const SizedBox(height: 50),
                  const Text(
                    "Какой ваш пол?",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGenderButton(
                        icon: Icons.male,
                        label: "Мужской",
                        isSelected: _selectedGender == "Мужской",  // исправил
                        onTap: () => setState(() => _selectedGender = "Мужской"),  // исправил
                      ),
                      const SizedBox(width: 20),
                      _buildGenderButton(
                        icon: Icons.female,
                        label: "Женский",
                        isSelected: _selectedGender == "Женский",  // исправил
                        onTap: () => setState(() => _selectedGender = "Женский"),  // исправил
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: Material(
                      color: const Color(0xFFE93C35),
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          if (_selectedGender == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Выберите пол")),
                            );
                            return;
                          }
                          context.read<RegistrationProvider>().setGender(_selectedGender!);  // добавил
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const IAmLooking()),
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

Widget _buildGenderButton({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 150,
      height: 120,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE93C35) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: isSelected ? Colors.white : const Color(0xFFE93C35)),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}