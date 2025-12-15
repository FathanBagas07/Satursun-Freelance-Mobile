import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _agree = true;

  @override
  void dispose() {
    _contactController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 140),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // =====Judul=====
            Center(
              child: Text(
                "Daftar",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            const SizedBox(height: 30),

            // ===== Form Data =====
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    "Nama Depan",
                    _firstNameController,
                    context,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    "Nama Belakang",
                    _lastNameController,
                    context,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _buildTextField("Nama Pengguna", _usernameController, context),
            const SizedBox(height: 10),

            _buildTextField("Email", _contactController, context),
            const SizedBox(height: 10),

            _buildTextField(
              "Sandi",
              _passwordController,
              context,
              isPassword: true,
            ),
            const SizedBox(height: 20),

            // ===== Checkbox =====
            Row(
              children: [
                Checkbox(
                  value: _agree,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    setState(() {
                      _agree = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Saya setuju dengan ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                      children: [
                        TextSpan(
                          text: 'Ketentuan Pengguna',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' dan '),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Tombol Daftar =====
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                  try {
                    final email = _usernameController.text.trim();
                    final password =_passwordController.text.trim();

                    await authService.signInwithEmail(
                      email: email,
                      password: password,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Login Gagal')),
                    );
                  }
                },
              child: Text(
                "Daftar",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 25),

            // ===== Atau =====
            Center(
              child: Text(
                "—————————— Atau ———————————",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),

            // ===== Daftar dengan Google =====
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surface,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                  try {
                    await authService.signInWithGoogle();
                  } on FirebaseAuthException catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Google Login Gagal')),
                    );
                  }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/google.png', height: 20),
                  const SizedBox(width: 10),
                  Text(
                    "Lanjutkan dengan Google",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ===== Sudah punya akun? Masuk =====
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Sudah punya akun? ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Masuk',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pop();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Text Field Builder =====
  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    BuildContext context, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
}