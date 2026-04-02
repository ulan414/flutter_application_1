import 'package:flutter/material.dart';

class MyEmail extends StatelessWidget {
  const MyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Layer
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. UI Layer
          SafeArea(
            child: SizedBox.expand( // Ensures the Column spans the full width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20), // Top padding

                  // --- 1. PROGRESS BAR (TOP) ---
                  Container(
                    width: 280,
                    height: 8,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE9F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 280 / 8 * 3,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE93C35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --- 2. LOGO ---
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: 200,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 50), // Space between logo and text

                  // --- 3. TEXT ---
                  const Text(
                    "Email адрес",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 350,
                    alignment: Alignment.center,
                  child:  Text(
                    "Нам понадобится ваш email, чтобы оставаться на связи",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFB9C7D2),
                    ),
                  ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "meiram@gmail.com", // This shows when the field is empty
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Left alignment spacing
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none, // Removes the default underline/border
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                  width: 350,
                  height: 56,
                  child: Material( // Added Material for InkWell splash to show
                    color: const Color(0xFFE93C35),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}