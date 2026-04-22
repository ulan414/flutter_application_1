import 'package:flutter/material.dart';
import 'phone_number.dart';
import 'my_number.dart';

class StartLog extends StatelessWidget {
  const StartLog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),

                  // Logo
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: size.width * 0.5,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Avatars
                  SizedBox(
                    height: size.height * 0.32,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildAvatar('assets/imgs/Ellipse8.png',
                            size.width * 0.35, -size.width * 0.2, -50),
                        _buildAvatar('assets/imgs/Ellipse12.png',
                            size.width * 0.3, size.width * 0.2, 15),
                        _buildAvatar('assets/imgs/Ellipse67.png',
                            size.width * 0.23, -size.width * 0.1, 80),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Text + buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Column(
                      children: [
                        Text(
                          "Найди своего партнера",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Text(
                          "Зажигай не только сигарету, но и крутой диалог. Твой идеальный напарник уже здесь",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.037,
                            color: const Color(0xFFB9C7D2),
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),

                        _buildMainButton(
                          context,
                          title: "Войти через телефон",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhoneNumber(),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: size.height * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Нет аккаунта?",
                              style: TextStyle(color: Color(0xFFB9C7D2)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyNumber(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Регистрация",
                                style: TextStyle(
                                  color: Color(0xFFFF5069),
                                  fontWeight: FontWeight.bold,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String asset, double size, double dx, double dy) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(asset, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}