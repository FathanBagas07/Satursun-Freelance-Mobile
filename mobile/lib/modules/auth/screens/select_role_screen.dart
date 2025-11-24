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
            Center(
              child: Text(
                "Pilih Peran",
                // MENGGUNAKAN THEME: displayMedium (24) + override color white dan bold
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Silahkan pilih peran Anda",
              textAlign: TextAlign.center,
              // MENGGUNAKAN THEME: bodyLarge (14) + override size 16 dan color white70
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Peran yang Anda pilih tidak dapat diganti setelah pendaftaran selesai",
              textAlign: TextAlign.center,
              // MENGGUNAKAN THEME: bodyLarge (14) + override color white70
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70),
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
          Navigator.pushNamedAndRemoveUntil(
              context, '/home-klien', (Route<dynamic> route) => false);
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
                // MENGGUNAKAN THEME: titleLarge (18) + override color black dan bold
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
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