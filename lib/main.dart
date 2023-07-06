import 'package:chatapp/screens/ChatPage.dart';
import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/SignUpPage.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        kLoginPageScreen: (context) => LoginPage(),
        kSignUpPageScreen: (context) => SignUpPage(),
        kChatPageScreen: (context) => ChatPage(),
      },
      initialRoute: kLoginPageScreen,
    );
  }
}
