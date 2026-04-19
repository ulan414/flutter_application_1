import 'package:flutter/material.dart';

import 'my_interests.dart';

class IAmLooking extends StatefulWidget {
  const IAmLooking({super.key});

  @override
  State<IAmLooking> createState() => _IAmLookingState();
}

class _IAmLookingState extends State<IAmLooking> {
  // This variable stores which option is currently selected
  String selectedOption = "";

  final List<String> options = [
    "напарник на перекур",
    "любитель пара",
    "компания на перекур",
    "ищу зажигалку",
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
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // --- PROGRESS BAR ---
                  _buildProgressBar(),
                  
                  const SizedBox(height: 20),
                  Image.asset('assets/imgs/logo.png', width: 150, fit: BoxFit.contain),

                  const SizedBox(height: 30),
                  const Text(
                    "Я ищу...",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  
                  const SizedBox(height: 30),

                  // --- FOUR OPTIONS ---
                  // We loop through the list and create a button for each
                  ...options.map((option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildSelectionButton(option),
                  )),

                  const Spacer(), // Pushes the "Continue" button to the bottom

                  // --- CONTINUE BUTTON ---
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

  // Helper for the selection buttons
  Widget _buildSelectionButton(String text) {
    bool isSelected = selectedOption == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = text;
        });
      },
      child: Container(
        width: 350,
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE93C35) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    bool canContinue = selectedOption.isNotEmpty;
    return Opacity(
      opacity: canContinue ? 1.0 : 0.5, // Fades button if nothing selected
      child: SizedBox(
        width: 350,
        height: 56,
        child: Material(
          color: const Color(0xFFE93C35),
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: canContinue ? () { 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyInterests(), // Replace 'Message' with your class name if it's different
                ),
              );
            } : null,
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
    );
  }

  Widget _buildProgressBar() {
    return SafeArea(
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
   );
  }
}