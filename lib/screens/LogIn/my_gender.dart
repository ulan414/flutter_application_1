import 'package:flutter/material.dart';

class MyGender extends StatelessWidget {
  const MyGender({super.key});

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
                  Container(
                    width: 280,
                    height: 8,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 280 / 8 * 5,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE93C35),
                        borderRadius: BorderRadius.circular(12),
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
                    "Какой ваш пол?",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // --- GENDER SELECTION ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Male Option
                      _buildGenderButton(
                        icon: Icons.male,
                        label: "Мужской",
                        isSelected: false, // You'll change this with state later
                        onTap: () {},
                      ),
                      const SizedBox(width: 20), // Space between buttons
                      // Female Option
                      _buildGenderButton(
                        icon: Icons.female,
                        label: "Женский",
                        isSelected: false, 
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
          Icon(
            icon,
            size: 40,
            color: isSelected ? Colors.white : const Color(0xFFE93C35),
          ),
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