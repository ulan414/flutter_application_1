import 'package:flutter/material.dart';
class CreateActivity extends StatelessWidget {
  const CreateActivity({super.key});
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
            'Создать актиность',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // The height of the area
          child: Container(
            color: Colors.white24, // "white24" is a subtle, thin-looking white
            height: 1.0,           // The actual thickness of the line
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Что делаем?',
                style: TextStyle(
                  color: Color.fromARGB(255, 201, 201, 201),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
              style: TextStyle(color: Colors.white, fontSize: 24), // Стиль вводимого текста
                decoration: InputDecoration(
                  hintText: 'Поход в кино',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 60, 70, 85), // Цвет как на скриншоте
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none, // Убираем стандартное подчеркивание
                  contentPadding: EdgeInsets.zero, // Убираем внутренние отступы самого поля
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'КАТЕГОРИЯ',
                style: TextStyle(
                  color: Color.fromARGB(255, 120, 120, 120),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('Тусовка', Icons.local_bar, isSelected: true),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Спорт', Icons.sports_soccer),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Еда', Icons.restaurant),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Кино', Icons.movie),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF23262B), // Темный фон карточки
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Поле описания
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notes, color: Colors.white.withOpacity(0.3), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              maxLines: 3,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Добавьте описание (опционально)...',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),

                    // Выбор времени
                    _buildSelectionRow(
                      icon: Icons.calendar_today,
                      iconColor: const Color(0xFFE53935), // Красный
                      label: 'КОГДА',
                      value: 'Сегодня, 19:00',
                      trailing: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2)),
                    ),

                    Divider(color: Colors.white.withOpacity(0.05), height: 1),

                    // Выбор места
                    _buildSelectionRow(
                      icon: Icons.location_on,
                      iconColor: const Color(0xFF4285F4), // Синий
                      label: 'ГДЕ',
                      value: 'Укажите место',
                      trailing: Icon(Icons.map_outlined, color: Colors.white.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Количество людей',
                    style: TextStyle(
                      color: Color.fromARGB(255, 201, 201, 201),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'макс: 10',
                    style: TextStyle(
                      color: Color(0xFFE53935),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF23262B), // Темный фон карточки
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8), // Отступ внутри коробки
                            decoration: BoxDecoration(
                              color: Colors.black, // Черный цвет коробки
                              borderRadius: BorderRadius.circular(8), // Скругление углов (по желанию)
                            ),
                            child: const Icon(Icons.remove, color: Colors.white, size: 25),
                          ),
                          Column(
                            children: [
                              Text(
                                '4',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 201, 201, 201),
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                'Человека',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 201, 201, 201),
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8), // Отступ внутри коробки
                            decoration: BoxDecoration(
                              color: Color(0xFFE53935), // Черный цвет коробки
                              borderRadius: BorderRadius.circular(8), // Скругление углов (по желанию)
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
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
                        Text(
                          "Опубликовать",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_right_alt, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCategoryChip(String label, IconData icon, {bool isSelected = false}) {
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
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 8),
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
Widget _buildSelectionRow({
  required IconData icon,
  required Color iconColor,
  required String label,
  required String value,
  required Widget trailing,
}) {
  return InkWell(
    onTap: () {}, // Сюда добавите логику открытия календаря или карты
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Иконка в закругленном квадрате
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          // Текст
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    ),
  );
}
}