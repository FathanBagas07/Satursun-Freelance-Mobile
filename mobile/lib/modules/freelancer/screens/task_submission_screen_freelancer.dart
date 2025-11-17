import 'package:flutter/material.dart';

// Definisi warna yang digunakan (lanjutan dari file sebelumnya)
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunRed = Color(0xFFE53935); // Untuk tombol "Kumpul"
const Color _saturSunGrey = Color(0xFFBDBDBD); // Untuk ikon delete

class TaskSubmissionScreen extends StatelessWidget {
  const TaskSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Biru Muda ke Oranye)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _saturSunBlue,
                  _saturSunLightBlue,
                  _saturSunOrange,
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Bottom navigation bar, fokus pada index 3 (Tugas)
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      // Tombol "Kumpul" di luar SingleChildScrollView agar selalu terlihat
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            // Aksi tombol "Kumpul"
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
            'Kumpul',
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
      // Padding bawah untuk memberi ruang pada tombol Kumpul
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),

          // --- Judul & Status ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengumpulan Tugas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // Tombol Progres
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Progres',
                    style: TextStyle(
                      color: _saturSunBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- Upload Area Card ---
          _buildUploadCard(),
          const SizedBox(height: 20),

          // --- Catatan Tambahan Card ---
          _buildNotesCard(),
          const SizedBox(height: 20),
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

  // --- Upload Area Card ---
  Widget _buildUploadCard() {
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
                  const Icon(Icons.assignment_outlined,
                      color: Colors.black, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'Desain Poster Acara Webinar Nasional',
                    style: TextStyle(
                      fontSize: 16,
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
          // Upload Area Dashed Border
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Icon(Icons.cloud_upload_outlined,
                    color: _saturSunBlue, size: 40),
                const SizedBox(height: 8),
                Text(
                  'Upload karya (max 20MB)',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Aksi pilih file
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _saturSunOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Pilih File',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Daftar File yang Sudah Diunggah
          _buildUploadedFileItem('poster_final_v2.jpg', '15MB'),
          _buildUploadedFileItem('konsep_warna.pdf', '350KB'),
        ],
      ),
    );
  }

  // Widget untuk Item File yang Sudah Diunggah
  Widget _buildUploadedFileItem(String fileName, String fileSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                fileName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                fileSize,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Aksi hapus file
                },
                child: const Icon(Icons.delete_outline,
                    color: _saturSunGrey, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Catatan Tambahan Card ---
  Widget _buildNotesCard() {
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
          const Text(
            'Catatan Tambahan (opsional)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'contoh : Halo, berikut hasil desainnya.',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _saturSunBlue, width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            style: const TextStyle(fontSize: 15),
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