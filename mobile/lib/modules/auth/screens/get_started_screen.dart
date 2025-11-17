import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar Latar Belakang (Diposisikan 50 piksel ke bawah)
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/get_started.png',
              fit: BoxFit.cover,
            ),
          ),

          // Overlay Gradasi di Bagian Bawah Gambar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.5),
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),

          // Konten ATAS (Hanya Logo Satursun)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 200),
                  SizedBox(height: 10),
                  // Tagline sudah dipindahkan dari sini
                ],
              ),
            ),
          ),

          // Konten BAWAH (Tagline & Tombol "Ayo Mulai")
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tagline dipindahkan ke sini
                  Text(
                    "Teman Freelance Pemula Akhir Pekan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 30), // Jarak antara teks dan tombol
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    child: Text(
                      "Ayo Mulai",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}