import 'package:flutter/material.dart';
import 'modules/auth/screens/get_started_screen.dart';
import 'modules/auth/screens/sign_in_screen.dart';

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
        '/': (context) => GetStartedScreen(),
        '/sign-in': (context) => SignInScreen(),
      },
    );
  }
}
