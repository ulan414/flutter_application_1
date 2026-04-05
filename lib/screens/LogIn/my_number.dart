import 'package:flutter/material.dart';

import 'verificationReg.dart';


class MyNumber extends StatelessWidget {
  const MyNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1️⃣ Background - используем Container с цветом или картинку
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2️⃣ Основной контент
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Логотип Redy
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
// 1. Оберни Image.asset в Container и ClipRRect
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Мягкая тень
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Большое закругление
                      child: Image.asset(
                        'assets/imgs/people.jpg',
                        width: 350, // Немного увеличим для акцента
                        fit: BoxFit.contain, // Сохраняем BoxFit.contain, если ширина приоритетна
                      ),
                    ),
                  ),
                  const Spacer(),


                // 4️⃣ Текстовый блок и кнопки
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const Text(
                        "Мой Номер",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Нам понадобится ваш номер телефона, чтобы отправить OTP для проверки.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFB9C7D2),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Кнопка входа
                      _buildMainButton(
                        context,
                        title: "Продолжить",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VerificationReg(), // Replace 'Message' with your class name if it's different
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Регистрация
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Есть аккаунт?",
                            style: TextStyle(color: Color(0xFFB9C7D2)),
                          ),
                          TextButton(
                            onPressed: () {

                            },
                            child: const Text(
                              "Войти",
                              style: TextStyle(
                                color: Color(0xFFFF5069),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Красивая кнопка
  Widget _buildMainButton(BuildContext context, {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5069), Color(0xFFFF8E5E)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF5069).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}