import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Goes back to the previous screen
          },
        ),
        title: 
          const Text(
            'Профиль',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              print("Settings pressed");
              // Add your navigation or logic here
            },
          ),
          // You can add more icons here if needed
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // The height of the area
          child: Container(
            color: Colors.white24, // "white24" is a subtle, thin-looking white
            height: 1.0,           // The actual thickness of the line
          ),
        ),
      ),
body: SingleChildScrollView( // Добавили скролл
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 30),
      // --- Твой блок с Аватаром ---
      Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFE85D32),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFF131221),
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/imgs/profile_image.png'),
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFF131221),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  color: Colors.blueAccent,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 30),
      // --- Имя и тег ---
      const Center(
        child: Text(
          "Мейрам Жанболатов",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      const Center(
        child: Text(
          "@meiram_zhanbolatov",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 158, 158, 158),
            letterSpacing: 0.3,
          ),
        ),
      ),
      const SizedBox(height: 30),
      // --- Блок Надежность ---
      Container(
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2F33),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shield, color: Color(0xFFFFD700), size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "НАДЕЖНОСТЬ",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "98% ", style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: "Высокая",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
      // --- Карточки статистики ---
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          children: [
            _buildStatCard("24", "Миссии", textColor: const Color(0xFFE85D32)),
            const SizedBox(width: 12),
            _buildStatCard("4.9", "Рейтинг"),
            const SizedBox(width: 12),
            _buildStatCard("128", "Друзья"),
          ],
        ),
      ),
      // --- Кнопка Редактировать ---
      SizedBox(
        width: 350,
        height: 56,
        child: Material(
          color: const Color(0xFFE93C35),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_outlined, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "Редактировать",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      const SizedBox(height: 30),

      // --- НОВЫЙ БЛОК: ИНТЕРЕСЫ ---
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Интересы',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Изменить',
                    style: TextStyle(color: Color(0xFFE93C35)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: const [
                  _InterestTag(label: 'Сноубординг', emoji: '🏂', isSelected: true),
                  _InterestTag(label: 'Фотография', emoji: '📸'),
                  _InterestTag(label: 'Пицца', emoji: '🍕'),
                  _InterestTag(label: 'Гейминг', emoji: '🎮'),
                  _InterestTag(label: 'Кофе', emoji: '☕'),
                  _InterestTag(label: 'Рок-музыка', emoji: '🎸'),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 40),
       // Отступ снизу для красоты
       Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Прошедшие миссии',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Все', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
      const SizedBox(height: 10),
      _buildMissionCard(
        title: "Бар-хоппинг пятница",
        subtitle: "Организатор: Вы • 3 дня назад",
        status: "Успех",
        statusColor: Colors.greenAccent,
        icon: Icons.local_bar,
        iconBg: Colors.indigo.withOpacity(0.2),
      ),
      _buildMissionCard(
        title: "Поход на Столбы",
        subtitle: "Участник • 2 недели назад",
        status: "Успех",
        statusColor: Colors.greenAccent,
        icon: Icons.terrain,
        iconBg: Colors.brown.withOpacity(0.2),
        extra: "Получено +15 репутации",
      ),
      _buildMissionCard(
        title: "Киномарафон Marvel",
        subtitle: "Участник • 1 месяц назад",
        status: "Завершено",
        statusColor: Colors.white38,
        icon: Icons.movie,
        iconBg: Colors.purple.withOpacity(0.2),
      ),
      const SizedBox(height: 80), // Отступ, чтобы контент не перекрывался нижней панелью
    ],
  ),
),
    ],
    
  ),
),
      
// Внутри Scaffold
floatingActionButton: FloatingActionButton(
  onPressed: () {},
  backgroundColor: const Color(0xFFE93C35),
  shape: const CircleBorder(),
  child: const Icon(Icons.add, color: Colors.white, size: 30),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
bottomNavigationBar: BottomAppBar(
  color: const Color(0xFF131221),
  shape: const CircularNotchedRectangle(), // Вырез под кнопку
  notchMargin: 8,
  child: SizedBox(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavIcon(Icons.home_outlined, "Главная", false),
        _buildNavIcon(Icons.explore_outlined, "Поиск", false),
        const SizedBox(width: 40), // Место для FAB кнопки
        _buildNavIcon(Icons.chat_bubble_outline, "Чаты", false, hasNotification: true),
        _buildNavIcon(Icons.person, "Профиль", true), // Активная вкладка
      ],
    ),
  ),
),
    );
  }
  Widget _buildStatCard(String value, String label, {Color textColor = Colors.white}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2F33), // Matching your dark grey theme
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white54, // Faded text for the label
            ),
          ),
        ],
      ),
    ),
  );
}
Widget _buildNavIcon(IconData icon, String label, bool isActive, {bool hasNotification = false}) {
  final color = isActive ? const Color(0xFFE93C35) : Colors.white38;
  return Column(
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
                decoration: const BoxDecoration(color: Color(0xFFE93C35), shape: BoxShape.circle),
              ),
            ),
        ],
      ),
      Text(label, style: TextStyle(color: color, fontSize: 10)),
    ],
  );
}
Widget _buildMissionCard({
  required String title,
  required String subtitle,
  required String status,
  required Color statusColor,
  required IconData icon,
  required Color iconBg,
  String? extra,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF2C2F33),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.white70),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 13)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        if (extra != null) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.white38, size: 16),
              const SizedBox(width: 4),
              Text(extra, style: const TextStyle(color: Colors.white38, fontSize: 13)),
            ],
          ),
        ]
      ],
    ),
  );
}

}
class _InterestTag extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;

  const _InterestTag({
    required this.label,
    required this.emoji,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE93C35).withOpacity(0.1) : const Color(0xFF2C2F33),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFFE93C35) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFE93C35) : Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}