import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LogIn/start.dart';
import 'screens/App/Profile.dart';
import 'screens/App/Create_Activity.dart';
import 'screens/App/Search.dart';
import 'screens/App/Chat.dart';
import 'screens/App/Message.dart';
import 'screens/App/Group.dart';

import 'screens/LogIn/start.dart';
import 'screens/LogIn/verificationLog.dart';
import 'screens/LogIn/phone_number.dart';
import 'screens/LogIn/my_name.dart';
import 'screens/LogIn/my_number.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 55, 44, 87),
        ),
      ),
      // Используем класс из другого файла
      //  home: const LogoScreen(), 
      // home: const PhoneNumber(), 
      home: const StartLog(), 


    );
  }
}