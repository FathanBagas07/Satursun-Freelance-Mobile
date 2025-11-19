import 'package:flutter/material.dart';

// Definisi warna
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunRed = Color(0xFFE53935);
const Color _saturSunGrey = Color(0xFFBDBDBD);

class TaskSubmissionScreen extends StatelessWidget {
  const TaskSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
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
      // Menggunakan CustomBottomNavBar (Index 3: Tugas)
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      
      // Tombol "Kumpul" melayang di atas BottomNavBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            // --- LOGIKA NAVIGASI ---
            // Kembali ke Daftar Tugas (Task List)
            Navigator.pop(context);
            
            // Opsional: Tampilkan pesan sukses
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Tugas berhasil dikumpulkan!"),
                backgroundColor: _saturSunOrange,
                duration: Duration(seconds: 2),
              ),
            );
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

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      // Padding bawah ekstra agar konten tidak tertutup tombol & nav bar
      padding: const EdgeInsets.only(bottom: 160),
      child: Column(
        children: [
          _buildAppBar(context),
          const SizedBox(height: 10),

          // Header Judul & Status
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Progres',
                    style: TextStyle(
                      color: _saturSunBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- KARTU UPLOAD (RATA TENGAH) ---
          // Center widget memastikan kartu berada di tengah horizontal
          Center(child: _buildUploadCard(context)),
          
          const SizedBox(height: 20),

          // --- CATATAN TAMBAHAN ---
          _buildNotesCard(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
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

  Widget _buildUploadCard(BuildContext context) {
    // Lebar kartu disesuaikan dengan layar minus margin kanan-kiri
    double cardWidth = MediaQuery.of(context).size.width - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu (Judul Tugas & Tombol Edit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menggunakan Expanded agar teks tidak menabrak tombol Edit
              const Expanded(
                child: Row(
                  children: [
                    Icon(Icons.assignment_outlined, color: Colors.black, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Desain Poster Acara',
                        overflow: TextOverflow.ellipsis, // Mencegah overflow teks
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 14,
                    color: _saturSunBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // --- AREA UPLOAD RATA TENGAH ---
          Container(
            width: double.infinity, // Memenuhi lebar parent
            height: 200, // Tinggi fix agar kotak terlihat proporsional (kotak)
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Konten vertikal di tengah
              crossAxisAlignment: CrossAxisAlignment.center, // Konten horizontal di tengah
              children: [
                const Icon(Icons.cloud_upload_outlined, color: _saturSunBlue, size: 50),
                const SizedBox(height: 15),
                Text(
                  'Upload karya (max 20MB)',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Logika pilih file
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _saturSunOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 0,
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
          const SizedBox(height: 20),
          
          // List File yang sudah diupload
          const Divider(),
          const SizedBox(height: 10),
          _buildUploadedFileItem('poster_final_v2.jpg', '15MB'),
          _buildUploadedFileItem('konsep_warna.pdf', '350KB'),
        ],
      ),
    );
  }

  Widget _buildUploadedFileItem(String fileName, String fileSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              Text(
                fileSize,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: (){},
                child: const Icon(Icons.delete_outline, color: _saturSunGrey, size: 20)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'contoh : Halo, berikut hasil desainnya.',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _saturSunBlue, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(15),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// --- Custom Bottom Nav Bar (Konsisten dengan file lain) ---
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 5;
    final double activePosition = (itemWidth * currentIndex) + (itemWidth / 2) - 28;

    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            left: activePosition,
            bottom: 20,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _saturSunOrange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _saturSunOrange.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _getIconForIndex(currentIndex),
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, Icons.home_outlined, "Beranda"),
                  _buildNavItem(context, 1, Icons.search, "Telusuri"),
                  _buildNavItem(context, 2, Icons.account_balance_wallet_outlined, "Dompet"),
                  _buildNavItem(context, 3, Icons.assignment_outlined, "Tugas"),
                  _buildNavItem(context, 4, Icons.person_outline, "Profil"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0: return Icons.home;
      case 1: return Icons.search;
      case 2: return Icons.account_balance_wallet;
      case 3: return Icons.assignment;
      case 4: return Icons.person;
      default: return Icons.home;
    }
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label) {
    final bool isActive = index == currentIndex;
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          switch (index) {
            case 0: Navigator.pushReplacementNamed(context, '/home-freelancer'); break;
            case 1: Navigator.pushReplacementNamed(context, '/explore-freelancer'); break;
            case 2: Navigator.pushReplacementNamed(context, '/wallet-freelancer'); break;
            case 3: Navigator.pushReplacementNamed(context, '/task-list-freelancer'); break;
            case 4: Navigator.pushReplacementNamed(context, '/profile-freelancer'); break;
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isActive ? const SizedBox(height: 24) : Icon(icon, color: Colors.grey, size: 26),
            if (!isActive) Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}