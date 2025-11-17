import 'package:flutter/material.dart';

// Definisi warna yang digunakan (lanjutan dari file sebelumnya)
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunGreen = Color(0xFF4CAF50); // Untuk tombol Detail Selesai
const Color _saturSunRed = Color(0xFFE53935); // Untuk tombol Detail Tugas Aktif
const Color _saturSunYellow = Color(0xFFFFC107); // Untuk progress bar

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Biru ke Oranye)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _saturSunBlue, // Atas
                  _saturSunLightBlue, // Tengah
                  _saturSunOrange, // Bawah
                ],
                stops: [0.0, 0.3, 0.9],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Bottom navigation bar dibuat terpisah, fokus pada index 3 (Tugas)
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  // --- AppBar & Body Konten Utama ---
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),

          // --- Filter Section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildFilterButton(
                  icon: Icons.calendar_today,
                  label: 'Semua Pekerjaan',
                  onTap: () {},
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    // Filter Lokasi
                    Expanded(
                      child: _buildFilterButton(
                        icon: Icons.location_on,
                        label: 'Lokasi: USU Medan',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Filter Harga
                    Expanded(
                      child: _buildFilterButton(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Harga: Rp 25k - 100k',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- Tugas Aktif Section ---
          _buildTaskHeader('Tugas Aktif'),
          _buildTaskCard(
            title: 'Desain Poster Event Kampus',
            subTitle: 'Bem Fasilkom-TI',
            price: 'Rp 75.000',
            progress: 0.3, // 30%
            progressLabel: '30% Selesai',
            isComplete: false,
          ),
          const SizedBox(height: 30),

          // --- Tugas Selesai Section ---
          _buildTaskHeader('Tugas Selesai'),
          _buildTaskCard(
            title: 'Editing Video Dokumentasi',
            subTitle: 'IMILKOM',
            price: 'Rp 75.000',
            progress: 1.0, // 100%
            progressLabel: '100% Selesai',
            isComplete: true,
          ),
          // Tambahkan tugas selesai lainnya
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // --- Widget AppBar Kustom ---
  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5),
              child: Text(
                'Daftar Tugas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget untuk tombol filter (Semua Pekerjaan/Lokasi/Harga) ---
  Widget _buildFilterButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    // Tentukan apakah tombol lebar (Semua Pekerjaan) atau kecil (Lokasi/Harga)
    final bool isWide = !label.contains(':');

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: isWide ? Border.all(color: Colors.grey[300]!) : null,
          ),
          child: Row(
            mainAxisAlignment:
                isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(icon, color: _saturSunBlue, size: 20),
              if (isWide) const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Header Tugas Aktif / Tugas Selesai ---
  Widget _buildTaskHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // --- Card Tugas (Aktif atau Selesai) ---
  Widget _buildTaskCard({
    required String title,
    required String subTitle,
    required String price,
    required double progress,
    required String progressLabel,
    required bool isComplete,
  }) {
    final Color detailColor = isComplete ? _saturSunGreen : _saturSunRed;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(height: 4),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isComplete ? _saturSunGreen : _saturSunOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Progress Bar
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(_saturSunYellow),
                  minHeight: 5,
                ),
              ),
              const SizedBox(width: 10),
              // Persentase Selesai
              Text(
                progressLabel,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 15),
              // Tombol Detail
              GestureDetector(
                onTap: () {
                  // Aksi Lihat Detail
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: detailColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
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
                      padding: EdgeInsets.only(top: 8), child: Icon(Icons.search)),
                  label: 'Telusuri'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8), child: Icon(Icons.shopping_bag_outlined)),
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
              child: const Icon(Icons.help_outline, color: Colors.white, size: 30), // Ikon sesuai gambar
            ),
          ),
        ],
      ),
    );
  }
}