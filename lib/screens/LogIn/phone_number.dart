import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LogIn/my_number.dart';
import 'package:flutter_application_1/screens/LogIn/verificationLog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 1. Changed to StatefulWidget to manage the Controller and Focus
class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  // 2. Define the Controller
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // 3. Clean up the controller when the widget is disposed
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true is usually better for forms
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // ScrollView allows the UI to move up when the keyboard appears
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60), // Manual padding for status bar
                
                // Logo
                Image.asset(
                  'assets/imgs/logo.png',
                  width: 228,
                  height: 200, // Reduced height to fit screens better
                  fit: BoxFit.contain,
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Войти через номер телефона",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // --- Phone Number Input ---
                      Container(
                        width: 350,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB9C7D2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _phoneController, // 4. ATTACH CONTROLLER HERE
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                          ),
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
                      const SizedBox(height: 30),

                      // --- Continue Button ---
                      SizedBox(
                        width: 350,
                        height: 56,
                        child: Material(
                          color: const Color(0xFFE93C35),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              final String rawInput = _phoneController.text.trim();
                              final String cleanNumber = rawInput.replaceAll(RegExp(r'\D'), '');

                              if (cleanNumber.length == 10) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerificationLog(phoneNumber: "+7$cleanNumber"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Введите корректный номер (10 цифр)"),
                                    backgroundColor: Colors.black87,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Продолжить",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),

                      // --- THE LINE SECTION ---
                      SizedBox(
                        width: 350,
                        child: Row(
                          children: [
                            Expanded(child: Divider(color: Colors.white54, thickness: 2)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "ИЛИ",
                                style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.white54, thickness: 2)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // --- Telegram Button ---
                      _socialButton(
                        icon: Icons.telegram,
                        iconColor: const Color(0xFF1877F2),
                        text: "Войти через Telegram",
                        onTap: () {},
                      ),

                      const SizedBox(height: 20),

                      // --- Google Button ---
                      _socialButton(
                        icon: FontAwesomeIcons.google,
                        iconColor: Colors.red,
                        text: "Войти через Google Account",
                        onTap: () {},
                      ),

                      const SizedBox(height: 40),

                      // Bottom registration text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Нет аккаунта?",
                            style: TextStyle(color: Color(0xFFB9C7D2), fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyNumber()),
                              );
                            },
                            child: const Text(
                              "Регистрация",
                              style: TextStyle(color: Color(0xFFFF5069), fontWeight: FontWeight.bold),
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

  // Helper widget to keep the code clean
  Widget _socialButton({required IconData icon, required Color iconColor, required String text, required VoidCallback onTap}) {
    return SizedBox(
      width: 350,
      height: 56,
      child: Material(
        color: const Color(0xFFB9C7D2),
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 30),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 30), // Balance the icon
              ],
            ),
          ),
        ),
      ),
    );
  }
}