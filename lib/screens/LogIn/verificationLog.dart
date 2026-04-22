import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_application_1/screens/App/Search.dart';

class VerificationLog extends StatefulWidget {
  final String phoneNumber;
  const VerificationLog({super.key, required this.phoneNumber});

  @override
  State<VerificationLog> createState() => _VerificationLogState();
}

class _VerificationLogState extends State<VerificationLog> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendSmsInitial();
  }

  Future<void> _sendSmsInitial() async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: widget.phoneNumber,
      );
    } catch (e) {
      _showSnackBar("Ошибка при отправке кода", Colors.red);
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _controllers.map((e) => e.text).join();

    if (otp.length < 6) {
      _showSnackBar("Введите 6-значный код", Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final AuthResponse res = await Supabase.instance.client.auth.verifyOTP(
        type: OtpType.sms,
        token: otp,
        phone: widget.phoneNumber,
      );

      if (res.session != null && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Search()),
          (route) => false,
        );
      }
    } on AuthException catch (error) {
      _showSnackBar(error.message, Colors.red);
    } catch (e) {
      _showSnackBar("Ошибка верификации", Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resendSms() async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: widget.phoneNumber,
      );
      _showSnackBar("Код отправлен повторно", Colors.green);
    } catch (e) {
      _showSnackBar("Ошибка при отправке", Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset(
              'assets/imgs/background.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),

                  // Logo scales with screen
                  Image.asset(
                    'assets/imgs/logo.png',
                    width: screenWidth * 0.45,
                    height: screenWidth * 0.45,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  const Text(
                    "Код Верификации",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Введите 6-значный код, отправленный на\n${widget.phoneNumber}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFB9C7D2),
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // OTP row — boxes scale with screen width
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => _buildOtpBox(index, screenWidth),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),

                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE93C35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _isLoading ? null : _verifyOtp,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Верифицировать",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Не получили СМС?",
                    style: TextStyle(color: Color(0xFFF0E1E1)),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: _resendSms,
                    child: const Text(
                      "Отправить еще раз",
                      style: TextStyle(
                        color: Color(0xFFE93C35),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBox(int index, double screenWidth) {
    // Scales between 36px (tiny phones) and 56px (tablets)
    final boxSize = (screenWidth / 9).clamp(36.0, 56.0);
    final fontSize = (screenWidth * 0.055).clamp(16.0, 22.0);

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: const BoxDecoration(
        color: Color(0xFFB9C7D2),
        shape: BoxShape.circle,
      ),
      child: TextField(
        controller: _controllers[index],
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
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