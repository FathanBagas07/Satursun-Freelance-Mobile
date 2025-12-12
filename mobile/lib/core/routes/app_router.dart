
import 'package:go_router/go_router.dart';

// Auth Screens
import '../../modules/auth/screens/get_started_screen.dart';
import '../../modules/auth/screens/sign_in_screen.dart';
import '../../modules/auth/screens/sign_up_screen.dart';
import '../../modules/auth/screens/otp_verification_screen.dart';
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

// Fake Auth State (nanti bisa diganti Firebase Auth)
bool isLoggedIn = false;

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', // Set default route
    redirect: (context, state) {
      // Route yang tidak butuh login
      final openRoutes = [
        '/',
        '/sign-in',
        '/sign-up',
        '/otp',
        '/select-role',
      ];

      // halaman yang dituju user
      final goingTo = state.matchedLocation;

      // Jika user belum login dan mencoba masuk ke halaman protected → redirect ke login
      if (!isLoggedIn && !openRoutes.contains(goingTo)) {
        return '/sign-in';
      }

      return null;
    },

    routes: [
      /// =============================
      /// 🔵 AUTH ROUTES
      /// =============================
      GoRoute(
        path: '/',
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final contactInfo = state.extra as String? ?? 'Unknown';
          return OtpVerificationScreen(contactInfo: contactInfo);
        },
      ),
      GoRoute(
        path: '/select-role',
        builder: (context, state) => SelectRoleScreen(),
      ),

      /// =============================
      /// 🟢 FREELANCER ROUTES
      /// =============================
      GoRoute(
        path: '/freelancer/home',
        builder: (context, state) => const HomeScreenFreelancer(),
      ),
      GoRoute(
        path: '/freelancer/explore',
        builder: (context, state) => const ExploreScreenFreelancer(),
      ),
      GoRoute(
        path: '/freelancer/wallet',
        builder: (context, state) => const WalletScreenFreelancer(),
      ),
      GoRoute(
        path: '/freelancer/tasks',
        builder: (context, state) => const TaskListScreen(),
      ),
      GoRoute(
        path: '/freelancer/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/freelancer/job/:id',
        builder: (context, state) {
          final jobId = state.pathParameters['id'];
          return JobDetailScreen(jobId: jobId);
        },
      ),
      GoRoute(
        path: '/freelancer/task-submission',
        builder: (context, state) => const TaskSubmissionScreen(),
      ),

      /// =============================
      /// 🔴 KLIEN ROUTES
      /// =============================
      GoRoute(
        path: '/klien/home',
        builder: (context, state) => const HomeScreenKlien(),
      ),
      GoRoute(
        path: '/klien/explore',
        builder: (context, state) => const ExploreScreenKlien(),
      ),
      GoRoute(
        path: '/klien/wallet',
        builder: (context, state) => const WalletScreenKlien(),
      ),
      GoRoute(
        path: '/klien/job',
        builder: (context, state) => const JobScreenKlien(),
      ),
      GoRoute(
        path: '/klien/profile',
        builder: (context, state) => const ProfileKlienScreen(),
      ),
      GoRoute(
        path: '/klien/job-post-first',
        builder: (context, state) => const JobPostFirstScreenKlien(),
      ),
      GoRoute(
        path: '/klien/job-post-second',
        builder: (context, state) => const JobPostSecondScreenKlien(),
      ),
    ],
  );
}
