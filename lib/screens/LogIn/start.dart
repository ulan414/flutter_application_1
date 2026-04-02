import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // 375 is standard Figma width
    final double scale = screenWidth / 375 * 1.5; 

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1️⃣ Full-screen background
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2️⃣ Logo
          Transform.translate(
            offset: const Offset(0, -70),
            child: Image.asset(
              'assets/imgs/logo.png',
              width: 228,
              height: 303,
              fit: BoxFit.contain,
            ),
          ),

          Center(
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 40,
                    child: Image.asset('assets/imgs/Ellipse8.png', width: 134 * scale, fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 70,
                    left: 225,
                    child: Image.asset('assets/imgs/Ellipse12.png', width: 110 * scale, fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 170,
                    left: 85,
                    child: Image.asset('assets/imgs/Ellipse67.png', width: 68 * scale * 1.2, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 150,
            left: 40,
            right: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Найди Своего Партнера Для Перекура",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Зажигай не только сигарету, но и крутой диалог. Твой идеальный напарник уже здесь",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB9C7D2),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Войти через телефон",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Нет аккаунта?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB9C7D2),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Навигация будет здесь
                      },
                      child: const Text(
                        "Регистрация",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF5069),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}