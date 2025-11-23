import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black, 
                  ),
                ),
              ),

              SizedBox(height: 30),
              
              TextField(
                controller: emailUsernameController,
                // MENGGUNAKAN THEME: bodyLarge
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Email / Nama Pengguna",
                  // MENGGUNAKAN THEME: bodyLarge
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
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
                // MENGGUNAKAN THEME: bodyLarge
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Sandi",
                  // MENGGUNAKAN THEME: bodyLarge
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
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
              
              // MENGGUNAKAN THEME: bodyLarge
              Center(
                child: Text("—————————— Atau ———————————", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black)),
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
                      // MENGGUNAKAN THEME: labelLarge (16) + override color black
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.black, 
                      ),
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
                  // MENGGUNAKAN THEME: labelLarge (16) + override size 18 dan color black
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black, 
                    fontSize: 18, 
                  ), 
                ),
              ),

              SizedBox(height: 10),
              
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Lupa kata sandi? ',
                    // MENGGUNAKAN THEME: bodyLarge
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Klik disini',
                        // MENGGUNAKAN THEME: bodyLarge
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: primaryOrange, 
                            fontWeight: FontWeight.bold),
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
                    // MENGGUNAKAN THEME: bodyLarge
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black), 
                    children: [
                      TextSpan(
                        text: 'Daftar',
                        // MENGGUNAKAN THEME: bodyLarge
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: primaryOrange, 
                            fontWeight: FontWeight.bold),
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