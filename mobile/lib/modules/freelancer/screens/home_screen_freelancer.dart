import 'package:flutter/material.dart';

// Definisi warna yang digunakan
// Sesuaikan dengan tema aplikasi Anda
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5); // Contoh warna biru
const Color _saturSunLightBlue = Color(0xFFD3E0F0); // Contoh warna biru muda

class HomeScreenFreelancer extends StatelessWidget {
  const HomeScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold memberikan struktur dasar halaman
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(context),
      // Bottom navigation bar dibuat terpisah di bawah
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  // Bagian AppBar (Header)
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0), // Tinggi yang disesuaikan
      child: Container(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
        decoration: const BoxDecoration(
          // Gradient seperti di gambar
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8AC1F5), // Warna biru muda atas
              Color(0xFFF8DC99), // Warna kuning/oranye bawah
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Logo Saturasun (menggunakan Placeholder/Image.asset)
            Image.asset(
              'assets/logo_saturasun.png', // Ganti dengan path logo Anda
              height: 30,
            ),
            const SizedBox(height: 8),
            const Text(
              'Halo, Saturfren!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bagian Body (Konten Utama)
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // --- Bagian Trending Weekend Jobs ---
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Trending Weekend Jobs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTrendingJobsSection(),
          const SizedBox(height: 20),
          // --- Bagian Job List (yang perlu Unggah Portofolio) ---
          _buildJobCard(
            title: 'Tutor Coding ASAP - Bayaran 2x',
            deadline: null,
          ),
          const SizedBox(height: 15),
          _buildJobCard(
            title: 'Desain Logo Event',
            deadline: 'Deadline jam 23.59 WIB',
          ),
          const SizedBox(height: 20),
          // Tambahkan konten lain di sini jika ada
        ],
      ),
    );
  }

  // Bagian Horizontal Job Cards (Trending)
  Widget _buildTrendingJobsSection() {
    return SizedBox(
      height: 180, // Tinggi untuk menampung card dan scrollbar
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildTrendingJobCard(
            jobTitle: 'Desain Poster\nEvent Kampus',
            salary: 'Rp 100.000',
            note: '(per poster)',
            recommendation: 'Recommended for Teknik Industri',
            color: _saturSunOrange,
          ),
          const SizedBox(width: 15),
          _buildTrendingJobCard(
            jobTitle: 'Tutor Mate\nDasar',
            salary: 'Rp 75.00',
            note: '',
            recommendation: 'Recommended...',
            color: _saturSunLightBlue,
          ),
          // Tambahkan Card lain jika diperlukan
        ],
      ),
    );
  }

  // Widget untuk Card Trending Job
  Widget _buildTrendingJobCard({
    required String jobTitle,
    required String salary,
    required String note,
    required String recommendation,
    required Color color,
  }) {
    return Container(
      width: 280, // Lebar card disesuaikan
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                salary,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15), // Background warna rekomendasi
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              recommendation,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Card Job yang membutuhkan Unggah Portofolio
  Widget _buildJobCard({required String title, String? deadline}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (deadline != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    deadline,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Aksi unggah portofolio
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _saturSunOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'Unggah Portofolio Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Ikon Daftar/List
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.assignment_outlined,
              size: 40,
              color: _saturSunOrange.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Transparan karena Box Decoration
        elevation: 0, // Hilangkan shadow bawaan
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _saturSunBlue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0, // Index halaman Home
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), // Atau ikon Wallet
            label: 'Dompet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          // Handle navigasi
        },
      ),
    );
  }
}