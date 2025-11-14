import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color primaryBlue = Colors.blue; 
    
    return Scaffold(
      backgroundColor: primaryBlue, 
      appBar: AppBar(
        backgroundColor: primaryBlue, 
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), 
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset('assets/logo.png', height: 70), 
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Selamat Datang", 
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),

              SizedBox(height: 30),
              
              TextField(
                controller: emailUsernameController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Email / Nama Pengguna", // Sesuai desain
                  hintStyle: TextStyle(color: Colors.grey[600]),
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
                  hintStyle: TextStyle(color: Colors.grey[600]),
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
                child: Text("— Atau —", style: TextStyle(color: Colors.white70)), // Teks "Atau"
              ),

              SizedBox(height: 20),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.public, color: primaryBlue), 
                label: Text(
                  "Lanjutkan dengan Google", // Sesuai desain
                  style: TextStyle(color: primaryBlue, fontSize: 16),
                ),
              ),

              SizedBox(height: 15),
              
              // Tombol Masuk
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Latar belakang oranye
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Masuk", // Teks "Masuk"
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),
              
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Lupa kata sandi? ',
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: 'Klik disini', // Teks "Klik disini"
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Belum punya akun? ',
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: 'Daftar', // Teks "Daftar"
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
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