import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:satursun_app/core/services/auth_service.dart';
import 'package:satursun_app/core/services/user_service.dart';
import '../../modules/auth/services/auth_listenable.dart';

// Auth Screens
import '../../modules/auth/screens/get_started_screen.dart';
import '../../modules/auth/screens/sign_in_screen.dart';
import '../../modules/auth/screens/sign_up_screen.dart';
// import '../../modules/auth/screens/otp_verification_screen.dart';
import '../../modules/auth/screens/select_role_screen.dart';

// Freelancer Screens
import '../../modules/freelancer/screens/home_screen_freelancer.dart';
import '../../modules/freelancer/screens/explore_screen_freelancer.dart';
import '../../modules/freelancer/screens/wallet_screen_freelancer.dart';
import '../../modules/freelancer/screens/task_list_screen_freelancer.dart';
import '../../modules/freelancer/screens/profile_screen_freelancer.dart';
import '../../modules/freelancer/screens/job_detail_screen.dart';
import '../../modules/freelancer/screens/task_submission_screen_freelancer.dart';

// Klien Screens
import '../../modules/klien/screens/home_screen_klien.dart';
import '../../modules/klien/screens/explore_screen_klien.dart';
import '../../modules/klien/screens/wallet_screen_klien.dart';
import '../../modules/klien/screens/job_screen_klien.dart';
import '../../modules/klien/screens/profile_screen_klien.dart';
import '../../modules/klien/screens/job_post_first_screen_klien.dart';
import '../../modules/klien/screens/job_post_second_screen_klien.dart';
import '../../modules/klien/screens/job_detail_screen_klien.dart';

class AppRouter {
  static final _authListenable = AuthListenable();

  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: _authListenable,

    redirect: (context, state) async {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggedIn = user != null;
      final currentPath = state.matchedLocation;

      final isAuthRoute = 
          currentPath == '/' || 
          currentPath == '/sign-in' || 
          currentPath == '/sign-up';
          // currentPath == '/otp';

      if (!isLoggedIn) {
        if (!isAuthRoute) return '/sign-in';
        return null;
      }

      if (currentPath == '/select-role') return null;

      if (isAuthRoute) {
         final role = await userService.getRole();

         switch (role) {
           case 'Freelancer':
             return '/freelancer/home';
           case 'Klien':
             return '/klien/home';
           default:
             return '/select-role';
         }
      }
      
      return null;
    },

    routes: [
      // AUTH
      GoRoute(path: '/', builder: (context, state) => const GetStartedScreen()),
      GoRoute(path: '/sign-in', builder: (context, state) => const SignInScreen()),
      GoRoute(path: '/sign-up', builder: (context, state) => const SignUpScreen()),
      // GoRoute(
      //   path: '/otp',
      //   builder: (context, state) {
      //     final contactInfo = state.extra as String? ?? 'Unknown';
      //     return OtpVerificationScreen(contactInfo: contactInfo);
      //   },
      // ),
      GoRoute(path: '/select-role', builder: (context, state) => const SelectRoleScreen()),

      // FREELANCER
      GoRoute(path: '/freelancer/home', builder: (context, state) => const HomeScreenFreelancer()),
      GoRoute(path: '/freelancer/explore', builder: (context, state) => const ExploreScreenFreelancer()),
      GoRoute(path: '/freelancer/wallet', builder: (context, state) => const WalletScreenFreelancer()),
      GoRoute(path: '/freelancer/tasks', builder: (context, state) => const TaskListScreen()),
      GoRoute(path: '/freelancer/profile', builder: (context, state) => const ProfileScreen()),
      
      GoRoute(
        path: '/freelancer/job-detail', 
        builder: (context, state) {
          final jobData = state.extra as Map<String, dynamic>? ?? {}; 
          return JobDetailScreen(jobData: jobData);
        },
      ),
      
      // === PERBAIKAN DI SINI (Menangkap parameter taskData) ===
      GoRoute(
        path: '/freelancer/task-submission',
        builder: (context, state) {
          // Ambil data dari extra, jika null berikan map kosong
          final taskData = state.extra as Map<String, dynamic>? ?? {};
          return TaskSubmissionScreen(taskData: taskData);
        },
      ),

      // KLIEN
      GoRoute(path: '/klien/home', builder: (context, state) => const HomeScreenKlien()),
      GoRoute(path: '/klien/explore', builder: (context, state) => const ExploreScreenKlien()),
      GoRoute(path: '/klien/wallet', builder: (context, state) => const WalletScreenKlien()),
      GoRoute(path: '/klien/job', builder: (context, state) => const JobScreenKlien()),
      GoRoute(path: '/klien/profile', builder: (context, state) => const ProfileKlienScreen()),
      GoRoute(path: '/klien/job-post-first', builder: (context, state) => const JobPostFirstScreenKlien()),
      GoRoute(
        path: '/klien/job-post-second',
        builder: (context, state) {
          final dataAwal = state.extra as Map<String, dynamic>? ?? {}; 
          return JobPostSecondScreenKlien(dataAwal: dataAwal);
        },
      ),
      GoRoute(
        path: '/klien/job-detail',
        builder: (context, state) {
          final jobData = state.extra as Map<String, dynamic>;
          return JobDetailScreenKlien(jobData: jobData);
        },
      ),
    ],
  );
}