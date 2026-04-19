import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'my_name.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';

class VerificationReg extends StatefulWidget {
  final String phoneNumber;
  const VerificationReg({super.key, required this.phoneNumber});

  @override
  State<VerificationReg> createState() => _VerificationRegState();
}

class _VerificationRegState extends State<VerificationReg> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  bool _isLoading = false;
  bool _isResending = false;  // добавил

  Future<void> _verifyOtp() async {
    final otp = _controllers.map((c) => c.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите полный код")),
      );
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
        context.read<RegistrationProvider>().setPhone(widget.phoneNumber);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyName()),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: $error"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // кнопка отправить снова
  Future<void> _resendOtp() async {
    setState(() => _isResending = true);

    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: widget.phoneNumber,
      );

      if (mounted) {
        // очищаем поля
        for (var c in _controllers) c.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Код отправлен повторно"), backgroundColor: Colors.green),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка: $error"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        children: [
          SizedBox.expand(child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover)),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Код Верификации", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 15),
                Text(
                  "Пожалуйста, введите код, который мы только что отправили на",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFFB9C7D2)),
                ),
                Text(
                  widget.phoneNumber,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => _buildOtpBox(
                    context,
                    index: index,
                    controller: _controllers[index],
                  )),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _buildVerifyButton(),
                const SizedBox(height: 20),

                // кнопка "отправить снова"
                _isResending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Color(0xFFB9C7D2), strokeWidth: 2),
                      )
                    : GestureDetector(
                        onTap: _resendOtp,
                        child: RichText(
                          text: const TextSpan(
                            text: "Не получили код? ",
                            style: TextStyle(fontSize: 14, color: Color(0xFFB9C7D2)),
                            children: [
                              TextSpan(
                                text: "Отправить снова",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: 350,
      height: 56,
      child: Material(
        color: const Color(0xFFE93C35),
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: _verifyOtp,
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Text("Верифицировать", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, {required int index, required TextEditingController controller}) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(color: Color(0xFFB9C7D2), shape: BoxShape.circle),
      child: TextField(
        controller: controller,
        autofocus: index == 0,
        onChanged: (value) {
          if (value.length == 1 && index < 5) FocusScope.of(context).nextFocus();
          if (value.isEmpty && index > 0) FocusScope.of(context).previousFocus();
        },
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(border: InputBorder.none, counterText: ""),
      ),
    );
  }
}