import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GoogleSignIn.instance.initialize();

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
