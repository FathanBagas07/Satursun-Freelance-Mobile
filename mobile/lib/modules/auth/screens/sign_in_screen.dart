import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // <-- TAMBAHKAN INI

class SignInScreen extends StatelessWidget {
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color primaryBlue = Colors.blue; 
    Color primaryOrange = Colors.orange;
    
    return Scaffold(
      backgroundColor: primaryBlue, 
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 0), 
              Center(
                child: Image.asset('assets/logo.png', height: 170), 
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Selamat Datang", 
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),

              SizedBox(height: 30),
              
              TextField(
                controller: emailUsernameController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Email / Nama Pengguna",
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                ),
              ),

              SizedBox(height: 10),
              
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Sandi",
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
                ),
              ),

              SizedBox(height: 20),
              
              Center(
                child: Text("————————————— Atau ——————————————", style: TextStyle(color: Colors.black)),
              ),

              SizedBox(height: 20),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Stack( 
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Image.asset('assets/google.png', height: 30),
                      ),
                    ),
                    Text(
                      "Lanjutkan dengan Google", 
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange, 
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Masuk", 
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), 
                ),
              ),

              SizedBox(height: 10),
              
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Lupa kata sandi? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Klik disini',
                        style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              
              // Bagian "Daftar" yang dapat diklik
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: TextStyle(color: Colors.black), 
                    children: [
                      TextSpan(
                        text: 'Daftar',
                        style: TextStyle(color: primaryOrange, fontWeight: FontWeight.bold),
                        // Logika navigasi ditambahkan di sini
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/sign-up');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}