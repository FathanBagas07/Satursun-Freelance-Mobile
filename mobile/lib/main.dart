import 'package:flutter/material.dart';
import 'modules/auth/screens/get_started_screen.dart';
import 'modules/auth/screens/sign_in_screen.dart';
import 'modules/auth/screens/sign_up_screen.dart'; 
import 'modules/auth/screens/otp_verification_screen.dart'; 
import 'modules/auth/screens/select_role_screen.dart'; 

void main() {
  runApp(SatursunApp());
}

class SatursunApp extends StatelessWidget {
  const SatursunApp({super.key});
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
        '/sign-up': (context) => SignUpScreen(),
        
        '/otp-verification': (context) {
          final contactInfo = ModalRoute.of(context)!.settings.arguments as String;
          return OtpVerificationScreen(contactInfo: contactInfo);
        },
        
        '/select-role': (context) => SelectRoleScreen(),
      },
    );
  }
}