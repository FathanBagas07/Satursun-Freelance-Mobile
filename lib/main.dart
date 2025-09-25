import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/get_started_screen.dart';
import 'screens/sign_in_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/get-started': (context) => GetStartedScreen(),
        '/sign-in': (context) => SignInScreen(),
      },
    );
  }
}
