import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart'; // Import the package

class Group extends StatelessWidget {
  const Group({super.key});
  @override
  Widget build(BuildContext context) {
    final participants = [
  {'name': 'Азамат', 'role': 'Организатор', 'isReady': 'true'},
  {'name': 'Айгерим', 'role': 'Участник', 'isReady': 'true'},
  {'name': 'Берик', 'role': 'Участник', 'isReady': 'true'},
  {'name': 'Сауле', 'role': 'Участник', 'isReady': 'true'},
];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // Центрируем по вертикали
          children: [
            // 1. Кнопка назад
            IconButton(
              padding: EdgeInsets.zero, // Убираем лишние отступы, если нужно
              constraints: const BoxConstraints(), 
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),

            // 2. Заголовок
            const Text(
              'Футбол 5x5',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            // 3. Кнопка фильтра

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white, size: 25),
              ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
        elevation: 0,
        automaticallyImplyLeading: false, // Отключаем стандартную кнопку назад
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white24,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // Optional: adds a nice bounce effect
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildMissionInf(
                'CyberZone Arena', 
                'assets/imgs/pc_club.jpg', 
                'Компьютерный клуб', 
                1500, 
                'Сегодня, 19:00', 
                'пр. Абая, 150',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Команда ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: '(4/5)',
                          style: TextStyle(color: Colors.redAccent.shade200),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text(
                      'Все',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildParticipantList(participants),
            ),
            _buildInviteFriendButton(),
            
            // Add a little extra space at the bottom so the last item 
            // isn't hidden behind the bottomNavigationBar
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0), // Spacing from the bottom of the screen
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important: allows column to only take needed space
            children: [
              _buildRouteButton(), // The new Red button
              const SizedBox(height: 12), // Space between buttons
              _buildLeaveButton(), // Your existing button
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildMissionInf(
  String title, 
  String imagePath, 
  String category, 
  int price, 
  String dateTime, 
  String location
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF23262B), // Dark background
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            // Dynamic Image
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(category, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('💰 $price ₸ / чел', style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 32, color: Colors.white10),
        _buildIconDetail(Icons.calendar_today, 'Дата и время', dateTime),
        const SizedBox(height: 16),
        _buildIconDetail(Icons.location_on, 'Место встречи', location),
      ],
    ),
  );
}

Widget _buildIconDetail(IconData icon, String label, String value) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.redAccent, size: 20),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ],
  );
}
Widget _buildParticipantList(List<Map<String, String>> participants) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF23262B), // Matches your mission card color
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: participants.asMap().entries.map((entry) {
          int idx = entry.key;
          var user = entry.value;
          
          return Column(
            children: [
              _buildParticipantItem(
                user['name']!,
                user['role']!,
                user['isReady'] == 'true',
              ),
              
              // Add a divider between all items except the last one
              if (idx != participants.length - 1)
                const Divider(color: Colors.white10, height: 1),
            ],
          );
        },).toList(),
        
      ),
    );
  }

  Widget _buildParticipantItem(String name, String role, bool isReady) {
    bool isOrganizer = role == 'Организатор';
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          // Avatar with online status
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.person, color: Colors.white54),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF23262B), width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: isOrganizer ? Colors.greenAccent : Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Ready Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Готов',
              style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInviteFriendButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adds the side spacing
    child: DottedBorder(
      // Ensure these parameters are exactly like this:
      color: Colors.white24, 
      strokeWidth: 1.5,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      child: Container(
        width: double.infinity,
        height: 40, // Increased to 40 for better look/tap target
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_sharp, color: Colors.white54, size: 20),
            SizedBox(width: 8),
            Text(
              'Пригласить друга',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
Widget _buildLeaveButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      height: 55,
      // Using a decoration to match the border and curved corners
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(20.0), // High value for "pill" shape
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.logout, color: Colors.red),
          const SizedBox(width: 12),
          Text(
            'Покинуть группу',
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget _buildRouteButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      height: 60, // Slightly taller than the leave button for emphasis
      decoration: BoxDecoration(
        color: const Color(0xFFE53935), // Primary red color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Action for 2GIS
        },
        borderRadius: BorderRadius.circular(20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text(
              'Построить маршрут в 2GIS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}