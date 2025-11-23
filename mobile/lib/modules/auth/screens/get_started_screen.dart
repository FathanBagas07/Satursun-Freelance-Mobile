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
                    Colors.white.withValues(alpha: 0.01),
                    Colors.white.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),

          // Konten ATAS (Hanya Logo Satursun)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 0), // Jarak dikembalikan ke 60
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 200), // Ukuran logo dikembalikan ke 60
                  SizedBox(height: 10),
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
                  Text(
                    "Teman Freelance Pemula Akhir Pekan",
                    textAlign: TextAlign.center,
                    // MENGGUNAKAN THEME: titleLarge (18) + override w500
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700, // Override weight dari w700 ke w500
                        color: Colors.black),
                  ),
                  SizedBox(height: 30),
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
                      // MENGGUNAKAN THEME: labelLarge (16) + override size 18
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: 18, // Override size dari 16 ke 18
                      ),
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