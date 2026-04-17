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
  // 1. Create 6 controllers for 6 digits
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;

  Future<void> _verifyOtp() async {
    // Combine all 6 digits
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

      if (res.session != null) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Search()),
            (route) => false,
          );
        }
      }
    } on AuthException catch (error) {
      _showSnackBar(error.message, Colors.red);
    } catch (e) {
      _showSnackBar("Ошибка верификации", Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  @override
void initState() {
  super.initState();
  // Trigger the SMS as soon as the user arrives on this screen
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
  Future<void> _resendSms() async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(phone: widget.phoneNumber);
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover),
          ),
          
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset('assets/imgs/logo.png', width: 180, height: 180),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const Text(
                        "Код Верификации",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Введите 6-значный код, отправленный на\n${widget.phoneNumber}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Color(0xFFB9C7D2), fontSize: 14),
                      ),
                      const SizedBox(height: 40),

                      // 2. OTP Row - Using a smaller size to fit 6 circles
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) => _buildOtpBox(index)),
                      ),

                      const SizedBox(height: 40),
                      
                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE93C35),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: _isLoading ? null : _verifyOtp,
                          child: _isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Верифицировать", style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      const Text("Не получили СМС?", style: TextStyle(color: Color(0xFFF0E1E1))),
                      GestureDetector(
                        onTap: _resendSms,
                        child: const Text("Отправить еще раз", style: TextStyle(color: Color(0xFFE93C35), fontWeight: FontWeight.bold)),
                      ),
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

  Widget _buildOtpBox(int index) {
    return Container(
      // Reduced width to 45-50 to ensure 6 boxes fit on standard screens
      width: 48,
      height: 48,
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
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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