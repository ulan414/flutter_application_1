import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';
import 'my_age.dart';

class MyEmail extends StatefulWidget {  // StatelessWidget -> StatefulWidget
  const MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/imgs/background.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              height: 8,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE9F1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: 3 / 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE93C35),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/imgs/logo.png', width: 200, fit: BoxFit.contain),
                  const SizedBox(height: 50),
                  const Text(
                    "Email адрес",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 350,
                    alignment: Alignment.center,
                    child: const Text(
                      "Нам понадобится ваш email, чтобы оставаться на связи",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Color(0xFFB9C7D2)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: TextField(
                      controller: _emailController, // добавил
                      keyboardType: TextInputType.emailAddress, // добавил
                      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "meiram@gmail.com",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 56,
                    child: Material(
                      color: const Color(0xFFE93C35),
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          context.read<RegistrationProvider>().setEmail(_emailController.text); // добавил
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyAge()),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}