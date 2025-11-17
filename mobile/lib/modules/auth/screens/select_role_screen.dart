import 'package:flutter/material.dart';

class SelectRoleScreen extends StatelessWidget {
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            // Deskripsi Peran
            Text(
              "Silahkan pilih peran Anda",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Peran yang Anda pilih tidak dapat diganti setelah pendaftaran selesai",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 40),

            // Pilihan Peran
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
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (Route<dynamic> route) => false);
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 140,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath, height: 70), 
              SizedBox(height: 10),
              Text(
                role,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 5),
              Icon(Icons.arrow_forward, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}