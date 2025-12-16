import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      final email = emailUsernameController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        throw FirebaseAuthException(
          code: 'empty-fields',
          message: 'Email dan sandi tidak boleh kosong',
        );
      }

      // 1. Login Firebase
      User? user = await authService.signInwithEmail(
        email: email,
        password: password,
      );

      if (user != null) {
        // 2. Ambil Role dari Firestore
        String? role = await authService.getUserRole(user.uid);

        if (!mounted) return;

        // 3. Arahkan Berdasarkan Role
        if (role == 'Freelancer') {
          context.go('/freelancer/home'); 
        } else if (role == 'Klien') {
          context.go('/klien/home'); 
        } else {
          // Jika belum ada role (misal error sebelumnya), arahkan ke pilih role
          context.go('/select-role');
        }
      }

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login gagal')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(child: Image.asset('assets/logo.png', height: 170)),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Selamat Datang",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
              const SizedBox(height: 30),

              // EMAIL INPUT
              TextField(
                controller: emailUsernameController,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // PASSWORD INPUT
              TextField(
                controller: passwordController,
                obscureText: true,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: "Sandi",
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // LOGIN BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        height: 24, width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                    : Text("Masuk",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontSize: 18, color: Colors.black),
                      ),
              ),
              const SizedBox(height: 20),

              // GOOGLE SIGN IN & REGISTER LINK
              Center(
                child: Text("—————————— Atau ———————————",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                   // Logic Google Sign In juga harus cek role
                   try {
                     User? user = await authService.signInWithGoogle();
                     if (user != null && context.mounted) {
                        String? role = await authService.getUserRole(user.uid);
                        if (context.mounted) {
                           if (role == 'Freelancer') context.go('/freelancer/home');
                           else if (role == 'Klien') context.go('/klien/home');
                           else context.go('/select-role');
                        }
                     }
                   } catch (e) {
                     // Handle error
                   }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png', height: 20),
                    const SizedBox(width: 10),
                    Text("Lanjutkan dengan Google",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Daftar',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () => context.push('/sign-up'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}