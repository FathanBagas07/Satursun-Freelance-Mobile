import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // <-- Diperlukan untuk TapGestureRecognizer

class SignUpScreen extends StatefulWidget {
  @override
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
    Color primaryBlue = Colors.blue;
    Color primaryOrange = Colors.orange;

    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
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
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: _buildTextField("Nama Depan", _firstNameController)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField("Nama Belakang", _lastNameController)),
                ],
              ),
              SizedBox(height: 10),

              _buildTextField("Nama Pengguna", _usernameController),
              SizedBox(height: 10),
              _buildTextField("Email atau Nomor Telepon", _contactController),
              SizedBox(height: 10),
              _buildTextField("Sandi", _passwordController, isPassword: true),
              SizedBox(height: 30),

              Center(
                child: Text("— Atau —", style: TextStyle(color: Colors.black)),
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
                      style: TextStyle(color: primaryBlue, fontSize: 16),
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
                    activeColor: primaryOrange,
                  ),
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        text: 'Saya setuju dengan ',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Ketentuan Pengguna',
                            style: TextStyle(
                                color: primaryOrange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' dan '),
                          TextSpan(
                            text: 'Kebijakan Privasi',
                            style: TextStyle(
                                color: primaryOrange,
                                fontWeight: FontWeight.bold),
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
                  backgroundColor: primaryOrange,
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Sudah punya akun? Masuk (Navigasi kembali ke Sign In)
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Masuk',
                        style: TextStyle(
                            color: primaryOrange, fontWeight: FontWeight.bold),
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

  Widget _buildTextField(String hint, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
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