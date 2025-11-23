import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

import 'modules/auth/screens/get_started_screen.dart';
import 'modules/auth/screens/sign_in_screen.dart';
import 'modules/auth/screens/sign_up_screen.dart'; 
import 'modules/auth/screens/otp_verification_screen.dart'; 
import 'modules/auth/screens/select_role_screen.dart'; 

// Import Screen Freelancer
import 'modules/freelancer/screens/home_screen_freelancer.dart';
import 'modules/freelancer/screens/explore_screen_freelancer.dart';
import 'modules/freelancer/screens/wallet_screen_freelancer.dart';
import 'modules/freelancer/screens/task_list_screen_freelancer.dart';
import 'modules/freelancer/screens/profile_screen_freelancer.dart';
import 'modules/freelancer/screens/job_detail_screen.dart';
import 'modules/freelancer/screens/task_submission_screen_freelancer.dart';

void main() {
  runApp(const SatursunApp());
}

class SatursunApp extends StatelessWidget {
  const SatursunApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satursun Freelance',
      debugShowCheckedModeBanner: false,
      theme: satursunAppTheme,
      initialRoute: '/',
      routes: {
        // --- Auth Routes ---
        '/': (context) => const GetStartedScreen(),
        '/sign-in': (context) => SignInScreen(),
        '/sign-up': (context) => SignUpScreen(),
        '/otp-verification': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final contactInfo = args is String ? args : 'Unknown';
          return OtpVerificationScreen(contactInfo: contactInfo);
        },
        '/select-role': (context) => SelectRoleScreen(),

        // --- Freelancer Main Menu Routes ---
        '/home-freelancer': (context) => const HomeScreenFreelancer(),
        '/explore-freelancer': (context) => const ExploreScreenFreelancer(),
        '/wallet-freelancer': (context) => const WalletScreenFreelancer(),
        '/task-list-freelancer': (context) => const TaskListScreen(),
        '/profile-freelancer': (context) => const ProfileScreen(),
        
        // --- Freelancer Sub-Pages ---
        '/job-detail': (context) => const JobDetailScreen(),
        '/task-submission': (context) => const TaskSubmissionScreen(),
      },
    );
  }
}