import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SatursunApp());
}

class SatursunApp extends StatelessWidget {
  const SatursunApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Satursun Freelance',
      debugShowCheckedModeBanner: false,
      theme: satursunAppTheme,
      routerConfig: AppRouter.router,
    );
  }
}
