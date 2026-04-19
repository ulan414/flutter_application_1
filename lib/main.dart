import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LogIn/start.dart';
import 'package:flutter_application_1/screens/LogIn/verificationReg.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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


// Startlog->VerificationReg->my_name->my_email->my_age->my_gender->IamLooking->MyInterests->my_photo->Main
// Startlog->VerificationLog->Main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load your custom named file
  await dotenv.load(fileName: "key.env"); 

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

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
      // home: const VerificationReg(phoneNumber: "+77751256005",), 
      home: const MyName(), 


    );
  }
}