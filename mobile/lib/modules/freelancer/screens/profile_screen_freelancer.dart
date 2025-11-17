import 'package:flutter/material.dart';

// Definisi warna yang digunakan (lanjutan dari file sebelumnya)
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                stops: [0.0, 0.35, 0.9],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Bottom navigation bar dibuat terpisah, fokus pada index 4 (Profil)
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  // --- AppBar & Body Konten Utama ---
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),

          // --- Portofolio Section ---
          _buildPortfolioCard(),
          const SizedBox(height: 20),

          // --- Mode Kuliah Section ---
          _buildStudyModeCard(),
          const SizedBox(height: 20),

          // --- Daftar Tugas Section ---
          _buildTaskListSection(),
          const SizedBox(height: 100), // Jarak untuk BottomNavBar
        ],
      ),
    );
  }

  // --- Header dan Info Profil ---
  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Aksi menu
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  // Foto Profil
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                        'assets/profile_pic.png'), // Ganti dengan path gambar
                    child: (const SizedBox
                        .shrink()), // Placeholder jika tidak ada gambar
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Monica Raquella',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Freelance Teknik | 4.8 (32 reviews)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Portofolio Card ---
  Widget _buildPortfolioCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.work_outline, color: Colors.black, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Portofolio',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 16,
                    color: _saturSunBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Upload Area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud_upload_outlined,
                    color: _saturSunBlue, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Upload karya (max 5MB)',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Mode Kuliah Card ---
  Widget _buildStudyModeCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.brightness_1,
                      color: _saturSunOrange, size: 14),
                  const SizedBox(width: 8),
                  const Text(
                    'Mode Kuliah',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Toggle Switch
              Switch(
                value: true, // Nilai default ON
                onChanged: (bool value) {
                  // Aksi ganti toggle
                },
                activeThumbColor: Colors.white,
                activeTrackColor: _saturSunOrange,
                inactiveThumbColor: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Auto-reply: "Sedang ujian, akan dibalas secepatnya"',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          // Ilustrasi (menggunakan placeholder)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPlaceholderImage(1),
              _buildPlaceholderImage(2),
              _buildPlaceholderImage(3),
            ],
          ),
        ],
      ),
    );
  }

  // Placeholder Ilustrasi (gunakan Image.asset jika ada)
  Widget _buildPlaceholderImage(int index) {
    return Container(
      width: 70,
      height: 70,
      color: _saturSunLightBlue.withValues(alpha: 0.5),
      child: Center(
          child: Text('Ilustrasi $index',
              style: TextStyle(fontSize: 10, color: _saturSunBlue))),
    );
  }

  // --- Daftar Tugas Section ---
  Widget _buildTaskListSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.assignment_outlined,
                      color: Colors.black, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Daftar Tugas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 16,
                    color: _saturSunBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          // Tugas Aktif
          _buildTaskItem(
            title: 'Desain Poster Event Kampus',
            subTitle: 'Bem Fasilkom-TI',
            progress: 0.3, // 30%
            progressLabel: '30% Selesai',
          ),
          const Divider(height: 30),
          // Tugas Kedua
          _buildTaskItem(
            title: 'Editing Video Dokumentasi',
            subTitle: 'Dikerjakan oleh : Arya',
            progress: 0.7, // 70%
            progressLabel: '70% Selesai',
          ),
        ],
      ),
    );
  }

  // Widget Item Tugas
  Widget _buildTaskItem({
    required String title,
    required String subTitle,
    required double progress,
    required String progressLabel,
  }) {
    return Column(
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Progress',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            Text(
              progressLabel,
              style: TextStyle(
                fontSize: 12,
                color: progress < 1.0 ? _saturSunOrange : _saturSunBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange),
          minHeight: 5,
        ),
      ],
    );
  }
}

// --- Bottom Navigation Bar (Disesuaikan dengan index 4: Profil) ---
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
                      padding: EdgeInsets.only(top: 8),
                      child: Icon(Icons.shopping_bag_outlined)),
                  label: 'Dompet'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8), child: Icon(Icons.help_outline)),
                  label: 'Tugas'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(top: 8), child: Icon(null)),
                  label: 'Profil'), // Placeholder untuk ikon tengah
            ],
            onTap: (index) {
              // Handle navigasi
            },
          ),
          // Floating Middle Icon (Profil)
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
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}