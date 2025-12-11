import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // <-- Diperlukan untuk TapGestureRecognizer

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/logo.png', height: 150),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Daftar",
                  // MENGGUNAKAN THEME: titleLarge (18) + override size 17 dan color black
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: _buildTextField("Nama Depan", _firstNameController, context)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField("Nama Belakang", _lastNameController, context)),
                ],
              ),
              SizedBox(height: 10),

              _buildTextField("Nama Pengguna", _usernameController, context),
              SizedBox(height: 10),
              _buildTextField("Email atau Nomor Telepon", _contactController, context),
              SizedBox(height: 10),
              _buildTextField("Sandi", _passwordController, context, isPassword: true),
              SizedBox(height: 30),

              // MENGGUNAKAN THEME: bodyLarge
              Center(
                child: Text("— Atau —", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
              ),
              SizedBox(height: 20),

              // Tombol Google
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png', height: 20),
                    SizedBox(width: 10),
                    Text(
                      "Lanjutkan dengan Google",
                      // MENGGUNAKAN THEME: labelLarge (16) + override color black
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Checkbox Persetujuan
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? newValue) {},
                    activeColor: Theme.of(context).colorScheme.secondary,
                  ),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        text: 'Saya setuju dengan ',
                        // MENGGUNAKAN THEME: bodySmall (12) + override size 13 dan color black
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, 
                            fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Ketentuan Pengguna',
                            // MENGGUNAKAN THEME: bodySmall (12) + override size 13, color orange, dan bold
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          TextSpan(text: ' dan '),
                          TextSpan(
                            text: 'Kebijakan Privasi',
                            // MENGGUNAKAN THEME: bodySmall (12) + override size 13, color orange, dan bold
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          TextSpan(text: ' Satursun Freelance'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  String contact = _contactController.text;
                  Navigator.pushNamed(
                    context, 
                    '/otp-verification',
                    arguments: contact.isNotEmpty ? contact : 'info kontak tidak diisi',
                  );
                },
                child: Text(
                  "Daftar",
                  // MENGGUNAKAN THEME: labelLarge (16) + override size 18
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              // Sudah punya akun? Masuk (Navigasi kembali ke Sign In)
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    // MENGGUNAKAN THEME: bodyLarge
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Masuk',
                        // MENGGUNAKAN THEME: bodyLarge + override color orange, dan bold
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary, 
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer() // <-- Menambahkan GestureRecognizer
                          ..onTap = () {
                            // Menggunakan Navigator.pop karena Sign Up dipanggil dari Sign In
                            Navigator.pop(context); 
                          },
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

  // Menambahkan BuildContext ke _buildTextField
  Widget _buildTextField(String hint, TextEditingController controller, BuildContext context, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      // MENGGUNAKAN THEME: bodyLarge
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        // MENGGUNAKAN THEME: bodyLarge + override color grey
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
}