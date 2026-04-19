import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';
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
          context.read<RegistrationProvider>().setInterests(selectedOptions);  // добавил
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyPhoto()),
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