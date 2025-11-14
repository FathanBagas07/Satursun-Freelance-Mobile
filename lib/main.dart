import 'package:flutter/material.dart';
import 'package:satursun_app/screens/get_started_screen.dart';
import 'package:satursun_app/screens/sign_in_screen.dart';

void main() {
  runApp(SatursunApp());
}

class SatursunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satursun Freelance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/get-started', // <-- Perubahan ada di baris ini
      routes: {
        '/get-started': (context) => GetStartedScreen(),
        '/sign-in': (context) => SignInScreen(),
      },
    );
  }
}