import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LogIn/start.dart';
import 'package:flutter_application_1/screens/LogIn/verificationReg.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';  // добавил

import 'screens/App/Profile.dart';
import 'screens/App/Create_Activity.dart';
import 'screens/App/Search.dart';
import 'screens/App/Chat.dart';
import 'screens/App/Message.dart';
import 'screens/App/Group.dart';
import 'screens/App/Activities.dart';


import 'screens/LogIn/start.dart';
import 'screens/LogIn/verificationLog.dart';
import 'screens/LogIn/phone_number.dart';
import 'screens/LogIn/my_name.dart';
import 'screens/LogIn/my_number.dart';

import 'providers/registration_provider.dart';  // добавил

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "key.env"); 

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    ChangeNotifierProvider(        // добавил
      create: (_) => RegistrationProvider(),
      child: const MyApp(),
    ),
  );
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
      // home: const AuthWrapper(),
      // home: const StartLog(),
      home: const Activity(),

    );
  }
}
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> { 
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          return const Search();
        } else {
          return const StartLog();
        }
      },
    );
  }
}