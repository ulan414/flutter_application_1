import 'package:flutter/material.dart';
class Message extends StatelessWidget {
  const Message({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        // Убираем лишний Column, если в заголовке только одна строка
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
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Сегодня', style: TextStyle(color: Colors.grey)),
            ),
          ),
          _buildMessage(
            'Кто берет мяч? У меня мой сдулся, к сожалению 😕', 
            '18:42', 
            isMe: false, 
            senderName: 'Алексей',
            avatarUrl: 'assets/imgs/profile_image.png'
          ),
          _buildMessage(
            'Я возьму, у меня есть новый. Купил на прошлой неделе.', 
            '18:45', 
            isMe: true
          ),
                    _buildMessage(
            'Кто берет мяч? У меня мой сдулся, к сожалению 😕', 
            '18:42', 
            isMe: false, 
            senderName: 'Алексей',
            avatarUrl: 'assets/imgs/profile_image.png'

          ),
          _buildMessage(
            'Я возьму, у меня есть новый. Купил на прошлой неделе.', 
            '18:45', 
            isMe: true
          ),
                    _buildMessage(
            'Кто берет мяч? У меня мой сдулся, к сожалению 😕', 
            '18:42', 
            isMe: false, 
            senderName: 'Алексей',
            avatarUrl: 'assets/imgs/profile_image.png'

          ),
          _buildMessage(
            'Я возьму, у меня есть новый. Купил на прошлой неделе.', 
            '18:45', 
            isMe: true
          ),
                    _buildMessage(
            'Кто берет мяч? У меня мой сдулся, к сожалению 😕', 
            '18:42', 
            isMe: false, 
            senderName: 'Алексей',
            avatarUrl: 'assets/imgs/profile_image.png'
          ),
          _buildMessage(
            'Я возьму, у меня есть новый. Купил на прошлой неделе.', 
            '18:45', 
            isMe: true
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10, // Чтобы поле поднималось вместе с клавиатурой
          left: 16,
          right: 16,
          top: 10,
        ),
        color: const Color(0xFF131221), // Цвет фона под тон чата
        child: Row(
          children: [
            // 1. Кнопка "Плюс"
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2C2F33),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),

            // 2. Поле ввода
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2F33),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Написать сообщение...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    border: InputBorder.none,
                    // Иконка смайлика внутри поля справа
                    suffixIcon: Icon(Icons.sentiment_satisfied_alt, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 3. Красная кнопка отправки
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935), // Тот самый красный
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildMessage(String text, String time, {bool isMe = false, String? senderName, String? avatarUrl}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      // Прижимаем сообщение влево или вправо
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Имя отправителя (только для чужих сообщений)
        if (!isMe && senderName != null)
          Padding(
            padding: const EdgeInsets.only(left: 50, bottom: 4),
            child: Text(senderName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Аватарка собеседника
            if (!isMe) ...[
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(avatarUrl ?? 'assets/imgs/default.jpg'),
              ),
              const SizedBox(width: 8),
            ],

            // Облако сообщения
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  // Серый для других, красный для меня
                  color: isMe ? const Color(0xFFE53935) : const Color(0xFF373E4E),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 16),
                  ),
                ),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),

        // Время и статус под сообщением
        Padding(
          padding: EdgeInsets.only(top: 4, left: isMe ? 0 : 50),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              if (isMe) ...[
                const SizedBox(width: 4),
                const Icon(Icons.done_all, color: Colors.redAccent, size: 14), // Галочки
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
}