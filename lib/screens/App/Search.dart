import 'package:flutter/material.dart';

import 'Create_Activity.dart';
import 'Profile.dart';
import 'Chat.dart';


class Search extends StatelessWidget {
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Астана',
                      style: TextStyle(
                        color: Color.fromARGB(255, 120, 120, 120),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Компьютерные клубы',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2C2F33),
                    shape: BoxShape.circle,
                  ),
                  child:  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.filter_list, color: Colors.white,)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryOption('Все', isSelected: true),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Рядом'),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Вип комнаты'),
                  const SizedBox(width: 8),
                  _buildCategoryOption('Буткемп'),
                  const SizedBox(width: 8),
                ],
              ),
            ),
              const SizedBox(height: 10),

          ],
        ),
        
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
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
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
          _buildTicket('CyberZone Arena', 'assets/imgs/pc_club.jpg', 'Пушкина 8', 750, 4.9),
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
              _buildNavIcon(Icons.home_outlined, "Главная", true, () {
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
              _buildNavIcon(Icons.chat_bubble_outline, "Чаты", false, () {
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
Widget _buildTicket(String name, String imgAdress, String location, int price, double rating, {bool isOpen = true}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF2C2F33), // Темно-серый фон карточки
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Верхняя часть с картинкой и бейджами
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                imgAdress,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Рейтинг (слева сверху)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(rating.toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            // Статус "Открыто" (справа сверху)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32), // Зеленый
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    CircleAvatar(radius: 3, backgroundColor: Colors.white),
                    SizedBox(width: 6),
                    Text('Открыто', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ],
        ),

        // 2. Информационная часть
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '$price ₸', style: const TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                        const TextSpan(text: '\nЗА ЧАС', style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 14),
                  const SizedBox(width: 4),
                  Text('$location • 0.8 км', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 16),
              
              // 3. Характеристики (ПК и Видяха)
              Row(
                children: [
                  _buildFeatureBadge(Icons.computer, 'Свободно ПК', '12', Colors.green),
                  const SizedBox(width: 10),
                  _buildFeatureBadge(Icons.speed, 'RTX 4090', '', Colors.white),
                ],
              ),
              const SizedBox(height: 16),

              // 4. Кнопка "Забронировать"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Забронировать', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Вспомогательный виджет для мелких плашек (ПК, Видяха)
Widget _buildFeatureBadge(IconData icon, String label, String value, Color valueColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF1E2124),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        if (value.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(value, style: TextStyle(color: valueColor, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
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