import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 1. Import Supabase
import 'verificationReg.dart';

class MyNumber extends StatefulWidget {
  const MyNumber({super.key});

  @override
  State<MyNumber> createState() => _MyNumberState();
}

class _MyNumberState extends State<MyNumber> {
  String _selectedCode = '+7';
  
  // 2. Add a Controller to capture the phone number
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  // 3. The Function to send OTP
  Future<void> _sendOtp() async {
    final number = _phoneController.text.trim();
    if (number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, введите номер")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final fullNumber = '$_selectedCode$number';
      
      await Supabase.instance.client.auth.signInWithOtp(
        phone: fullNumber,
      );

      if (mounted) {
        // Navigate to verification and pass the phone number so we can use it there
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationReg(phoneNumber: fullNumber),
          ),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Произошла ошибка"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10), // Adjust padding as needed
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset('assets/imgs/logo.png', width: 200, fit: BoxFit.contain),
                const Spacer(),
                // Фотография
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
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const Spacer(),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const Text("Мой Номер", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 12),
                      const Text(
                        "Нам понадобится ваш номер телефона, чтобы отправить OTP для проверки.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Color(0xFFB9C7D2)),
                      ),
                      const SizedBox(height: 30),

                      // 📱 Phone Input Field
                      Container(
                        height: 55,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCode,
                                items: <String>['+7', '+1', '+44', '+995']
                                    .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
                                    .toList(),
                                onChanged: (val) => setState(() => _selectedCode = val!),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _phoneController, // 4. Attach controller
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(hintText: "Номер телефона", border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 5. Loading Indicator or Button
                      _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : _buildMainButton(
                            context,
                            title: "Продолжить",
                            onTap: _sendOtp, // 6. Link function
                          ),
                      
                      const SizedBox(height: 20),
                      // ... (rest of your UI)
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

  // (Keep your _buildMainButton helper method here)

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