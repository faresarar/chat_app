import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App ',
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginScreen': (context) => const LoginScreen(),
        'SignUpScreen': (context) =>  const SignUpScreen(),
        'ChatScreen': (context) =>  const ChatScreen()

      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "LoginScreen",

      /// because of we are using routes we need to to replace home with initialRoute
      //home: const LoginScreen(),
    );
  }
}
