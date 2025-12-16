import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satursun_app/core/services/auth_service.dart';
import 'auth_listenable.dart';

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

class AppRouter {
  static final _authListenable = AuthListenable();

  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: _authListenable,

    redirect: (context, state) async {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggedIn = user != null;
      final currentPath = state.matchedLocation;

      // Routes yang bisa diakses tanpa login
      final isAuthRoute = 
          currentPath == '/' || 
          currentPath == '/sign-in' || 
          currentPath == '/sign-up' || 
          currentPath == '/otp';

      // 1. Jika belum login, tendang ke sign-in (kecuali sedang di auth route)
      if (!isLoggedIn) {
        if (!isAuthRoute) return '/sign-in';
        return null;
      }

      // 2. Jika sudah login
      
      // Izinkan akses ke Select Role
      if (currentPath == '/select-role') return null;

      // Jika user di halaman Auth, arahkan ke Home sesuai Role
      if (isAuthRoute) {
        final role = await authService.getUserRole(user.uid);
        if (role == 'Freelancer') return '/freelancer/home';
        if (role == 'Klien') return '/klien/home';
        return '/select-role';
      }

      return null;
    },

    routes: [
      // ... (Route Auth & Freelancer Tetap Sama, Tidak Diubah) ...
      GoRoute(path: '/', builder: (context, state) => const GetStartedScreen()),
      GoRoute(path: '/sign-in', builder: (context, state) => const SignInScreen()),
      GoRoute(path: '/sign-up', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/select-role', builder: (context, state) => const SelectRoleScreen()),
      
      GoRoute(path: '/freelancer/home', builder: (context, state) => const HomeScreenFreelancer()),
      // ... dst ...

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
      
      // === UPDATE BAGIAN INI ===
      GoRoute(
        path: '/klien/job-post-second',
        builder: (context, state) {
          // Ambil data yang dikirim dari screen pertama
          final dataAwal = state.extra as Map<String, dynamic>? ?? {}; 
          return JobPostSecondScreenKlien(dataAwal: dataAwal);
        },
      ),
    ],
  );
}