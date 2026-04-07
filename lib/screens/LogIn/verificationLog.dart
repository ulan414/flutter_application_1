import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationLog extends StatelessWidget {
  const VerificationLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


        // Progress bar
        Transform.translate(
          offset: const Offset(0, 50),
          child: Container(
            width: 280,
            height: 8,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: 35,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFE93C35),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        Positioned(
          top: 220,
          left: 40,
          right: 40,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              "Код Верификации",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Пожалуйста, введите код, который мы только что отправили на",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB9C7D2),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "+77752229988",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30), // Отступ перед кодом

            // --- БЛОК ВВОДА OTP ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOtpBox(context, isFirst: true),
                _buildOtpBox(context),
                _buildOtpBox(context),
                _buildOtpBox(context, isLast: true),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Не получили СМС?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0E1E1),
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              "Отправить еще раз",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE93C35),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 30), 
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
                          "Верифицировать",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
          ]),
        )
      ],
    ));
  }

  // Виджет одного кружка
  Widget _buildOtpBox(BuildContext context, {bool isFirst = false, bool isLast = false}) {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFFB9C7D2), // Тот самый цвет из твоего дизайна
        shape: BoxShape.circle,
      ),
      child: TextField(
        onChanged: (value) {
          if (value.length == 1 && !isLast) {
            FocusScope.of(context).nextFocus(); // Прыжок вперед
          }
          if (value.isEmpty && !isFirst) {
            FocusScope.of(context).previousFocus(); // Прыжок назад
          }
        },
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          hintText: "-",
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}