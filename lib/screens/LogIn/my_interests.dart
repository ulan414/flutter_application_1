import 'package:flutter/material.dart';

import 'my_photo.dart';

class MyInterests extends StatefulWidget {
  const MyInterests({super.key});

  @override
  State<MyInterests> createState() => _MyInterestsState();
}

class _MyInterestsState extends State<MyInterests> {
  // 1. Change to a List to store multiple selections
  final List<String> selectedOptions = [];

  final List<String> options = [
    "Компьютерные игры",
    "Рыбалка",
    "Кино",
    "Футбол",
    "Поболтать",
    "Прогулка",
    "Велосипеды",
    "Спорт зал",
    "Музыка",
    "Кофе",
    "Книги",
    "Шопинг",
    "Рисование",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildProgressBar(),
                  const SizedBox(height: 20),
                  Image.asset('assets/imgs/logo.png', width: 150, fit: BoxFit.contain),
                  const SizedBox(height: 30),
                  const Text(
                    "Мои интересы",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 30),

                  // 2. Use Wrap for horizontal + vertical flow
                  Wrap(
                    spacing: 10,    // horizontal gap
                    runSpacing: 12, // vertical gap
                    alignment: WrapAlignment.center,
                    children: options.map((option) => _buildSelectionButton(option)).toList(),
                  ),
                  
                  const Spacer(),
                  _buildContinueButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton(String text) {
    // 3. Check if the list contains this specific text
    bool isSelected = selectedOptions.contains(text);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedOptions.remove(text); // Deselect if already there
          } else {
            selectedOptions.add(text);    // Add if not there
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE93C35) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        // Removed fixed width/height so it shrinks to text size
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    bool canContinue = selectedOptions.isNotEmpty;
    return Opacity(
      opacity: canContinue ? 1.0 : 0.5,
      child: ElevatedButton(
        onPressed: canContinue ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyPhoto(), // Replace 'Message' with your class name if it's different
            ),
          );
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE93C35),
          minimumSize: const Size(350, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text("Продолжить", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      width: 280, height: 8,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: const Color(0xFFFFE9F1), borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 280 / 8 * 7, height: 8,
        decoration: BoxDecoration(color: const Color(0xFFE93C35), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}