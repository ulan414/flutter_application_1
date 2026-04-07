import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LogIn/my_number.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_application_1/screens/App/Search.dart';


class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use resizeToAvoidBottomInset to prevent keyboard overflow
      resizeToAvoidBottomInset: false, 
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        children: [
          // 1️⃣ Background
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2️⃣ Logo
          Transform.translate(
            offset: const Offset(0, -10),
            child: Image.asset(
              'assets/imgs/logo.png',
              width: 228,
              height: 303,
              fit: BoxFit.contain,
            ),
          ),

          // 3️⃣ Content
          Positioned(
            top: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: const Text(
                    "Войти через номер телефона",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Phone Number Input ---
                SizedBox(
                  width: 350,
                  height: 56,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFB9C7D2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: "Номер телефона",
                        hintStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/imgs/kazakhstan_flag.png',
                                  width: 28,
                                  height: 28,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text("+7", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                              const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54),
                              const SizedBox(width: 10),
                              Container(height: 24, width: 1, color: Colors.grey[400]),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Continue Button ---
                SizedBox(
                  width: 350,
                  height: 56,
                  child: Material( // Added Material for InkWell splash to show
                    color: const Color(0xFFE93C35),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Search(), // Replace 'Message' with your class name if it's different
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // ▬▬▬ THE LINE SECTION ▬▬▬
               SizedBox(
                  width: 350,
                  height: 30, // Force a strict vertical bounding box
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Force vertical alignment
                    children: [
                      Expanded(
                        child: Container(
                          height: 2, // Bumped to 2px to bypass anti-aliasing bugs
                          color: Colors.white54, // Bright red to guarantee contrast
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "ИЛИ",
                          style: TextStyle(
                            color: Colors.white54, 
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- Telegram Button ---
                SizedBox(
                  width: 350,
                  height: 56,
                  child: Material(
                    color: const Color(0xFFB9C7D2),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.telegram, color: Color(0xFF1877F2), size: 40),
                          ),
                          Expanded(
                            child: Text(
                              "Войти через Telegram",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(width: 50), // To balance the icon width
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Google Button ---
                SizedBox(
                  width: 350,
                  height: 56,
                  child: Material(
                    color: const Color(0xFFB9C7D2),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(FontAwesomeIcons.google, color: Colors.red, size: 30),
                          ),
                          Expanded(
                            child: Text(
                              "Войти через Google Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                ),
                //bottom
                const SizedBox(height: 50),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyNumber(), // Replace 'Message' with your class name if it's different
                          ),
                        );
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