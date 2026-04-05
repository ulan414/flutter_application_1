import 'package:flutter/material.dart';

import 'Create_Activity.dart';
import 'Profile.dart';
import 'Search.dart';
import 'Message.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 180, // Увеличили высоту для поиска
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Заголовок
            const Text(
              'Чаты',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32, // Сделал крупнее, как на макете
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // 2. Поисковая строка
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2F33).withOpacity(0.5), // Темный фон поиска
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Поиск',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Категории
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryOption('Все', isSelected: true),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Миссии'),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Личные'),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Архив'),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // The height of the area
          child: Container(
            color: Colors.white24, // "white24" is a subtle, thin-looking white
            height: 1.0,           // The actual thickness of the line
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20), // Чтобы последний билет не прилипал к низу
        children: [
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точкувыоаворвавоа', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),
          _builtMessage('Доставка: Неон-Сити', 'assets/imgs/profile_image.png', 'Вы: Груз получен, выдвигаюсь на точку...', '14:20'),


        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF131221),
        shape: const CircularNotchedRectangle(), // Вырез под кнопку
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavIcon(Icons.home_outlined, "Главная", false, () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Search())
                );
              }),
              
              _buildNavIcon(Icons.map_outlined, "Карта", false, () {
                // Navigator.push logic for Map
              }),

              // Your FAB button (Add logic here too!)
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateActivity()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: const Icon(Icons.add),
                ),
              ),

              // THE MESSAGE SCREEN BUTTON
              _buildNavIcon(Icons.chat_bubble_outline, "Чаты", true, () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Chat())
                );
              }, hasNotification: true),

              _buildNavIcon(Icons.person_outline, "Профиль", false, () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Profile())
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
   Widget _buildCategoryOption(String label, {bool isSelected = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      // Красный цвет для активной категории, темно-серый для остальных
      color: isSelected ? Color(0xFFE53935) : Color(0xFF2C2F33),
      borderRadius: BorderRadius.circular(25),
      boxShadow: isSelected ? [
        BoxShadow(
          color: Color(0xFFE53935).withOpacity(0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        )
      ] : null,
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
Widget _builtMessage(String name, String imgAdress, String lastmessage, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Аватарка со статусом
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // Скругленные углы как на фото
              child: Image.asset(
                imgAdress,
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            // Зеленая точка (онлайн)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32), // Зеленый статус
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF131221), width: 2), // Обводка в цвет фона
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),

        // 2. Текстовая часть
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Имя и время
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xFFE53935), // Красное время как на макете
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Последнее сообщение
              Text(
                lastmessage,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Обрезает текст многоточием
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
Widget _buildNavIcon(
  IconData icon, 
  String label, 
  bool isActive, 
  VoidCallback onTap, // <--- Add this parameter
  {bool hasNotification = false}
) {
  final color = isActive ? const Color(0xFFE93C35) : Colors.white38;
  
  return GestureDetector( // <--- Wrap with GestureDetector
    onTap: onTap, 
    behavior: HitTestBehavior.opaque, // Makes the entire area clickable
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Icon(icon, color: color),
            if (hasNotification)
              Positioned(
                right: 0,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE93C35), 
                    shape: BoxShape.circle
                  ),
                ),
              ),
          ],
        ),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
      ],
    ),
  );
}
}