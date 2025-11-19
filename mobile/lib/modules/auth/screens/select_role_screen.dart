import 'package:flutter/material.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryBlue = Colors.blue;

    return Scaffold(
      backgroundColor: primaryBlue,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/logo.png', height: 40),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Pilih Peran",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              "Silahkan pilih peran Anda",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const Text(
              "Peran yang Anda pilih tidak dapat diganti setelah pendaftaran selesai",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleCard(
                    context, 'assets/freelancer_icon.png', "Freelancer"),
                _buildRoleCard(context, 'assets/client_icon.png', "Klien"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String iconPath, String role) {
    return GestureDetector(
      onTap: () {
        if (role == "Freelancer") {
          // Navigasi ke Home Freelancer dan hapus history login
          Navigator.pushNamedAndRemoveUntil(
              context, '/home-freelancer', (Route<dynamic> route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Mode Klien belum tersedia")),
          );
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath, 
                height: 70,
                errorBuilder: (c,e,s) => const Icon(Icons.person, size: 70, color: Colors.grey),
              ), 
              const SizedBox(height: 10),
              Text(
                role,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_forward, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}