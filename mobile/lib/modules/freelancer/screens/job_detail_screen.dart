import 'package:flutter/material.dart';

// Definisi warna yang digunakan (lanjutan dari file sebelumnya)
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunRed = Color(0xFFE53935); // Untuk tombol "Kerjakan"

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Biru Muda di bagian atas)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _saturSunBlue,
                  _saturSunLightBlue,
                ],
                stops: [0.0, 0.25],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Bottom navigation bar, fokus pada index 3 (Tugas)
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      // Tombol "Kerjakan" di luar SingleChildScrollView agar selalu terlihat
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            // Aksi tombol "Kerjakan"
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _saturSunRed,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          child: const Text(
            'Kerjakan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // --- AppBar & Body Konten Utama ---
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      // Padding bawah untuk memberi ruang pada tombol Kerjakan
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),

          // --- Job Info Section (Judul, Poster, Poster) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Desain Webinar :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Desain Poster Acara Webinar Nasional',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Diposting Oleh : BEM Fasilkom-TI USU',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                // Tenggat & Bayaran Cards
                Row(
                  children: [
                    Expanded(
                        child: _buildInfoCard(
                            Icons.calendar_today, 'Tenggat :', '10 Hari')),
                    const SizedBox(width: 15),
                    Expanded(
                        child: _buildInfoCard(Icons.payment, 'Bayaran :',
                            'Rp 75.000', _saturSunOrange)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- Deskripsi Pekerjaan Section ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deskripsi Pekerjaan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Kami dari BEM Fasilkom-TI USU membutuhkan seorang desainer grafis untuk membuat poster acara "Webinar Nasional: AI for Future Generation". Desain diharapkan terlihat modern, profesional, dan sesuai dengan tema teknologi.',
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Detail yang harus ada di poster:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint('Judul Acara & Tema'),
                _buildBulletPoint('Nama dan foto 2 orang pembicara'),
                _buildBulletPoint('Waktu & Tanggal Pelaksanaan'),
                _buildBulletPoint('Platform (Zoom Meeting)'),
                _buildBulletPoint('Link Pendaftaran'),
                _buildBulletPoint('Logo Universitas dan BEM'),
                const SizedBox(height: 15),
                const Text(
                  'Keahlian yang Dibutuhkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint(
                    'Menguasai software desain (Canva, Figma, Adobe Photoshop, CorelDRAW, dll.)'),
                _buildBulletPoint(
                    'Memiliki pemahaman yang baik tentang tata letak dan tipografi.'),
                // Tambahkan sisa konten deskripsi jika ada
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget AppBar Kustom ---
  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Aksi kembali
              },
            ),
            const Text(
              'SaturSun Freelance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Info Card (Tenggat/Bayaran) ---
  Widget _buildInfoCard(
      IconData icon, String label, String value,
      [Color valueColor = Colors.black]) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _saturSunBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Bullet Point ---
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 15)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Navigation Bar (Disesuaikan dengan index 3: Tugas) ---
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const Color saturSunOrange = Color(0xFFF98B00);
    const Color saturSunBlue = Color(0xFF1E88E5);

    return Container(
      height: 70, // Tinggi disesuaikan
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: saturSunBlue,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.search)),
                  label: 'Telusuri'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.shopping_bag_outlined)),
                  label: 'Dompet'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8), child: Icon(null)),
                  label: 'Tugas'), // Placeholder untuk ikon tengah
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Profil'),
            ],
            onTap: (index) {
              // Handle navigasi
            },
          ),
          // Floating Middle Icon (Tugas)
          Positioned(
            bottom: 10,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: saturSunOrange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: saturSunOrange.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
              ),
              child: const Icon(Icons.help_outline, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}