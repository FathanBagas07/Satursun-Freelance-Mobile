import 'package:flutter/material.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
// ignore: unused_element
const Color _saturSunBlue = Color(0xFF1E88E5); 
const Color _saturSunLightBlue = Color(0xFFD3E0F0); 

class HomeScreenFreelancer extends StatelessWidget {
  const HomeScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(context),
      // Index 0 untuk Beranda
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: Container(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8AC1F5), Color(0xFFF8DC99)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 30,
              errorBuilder: (c,e,s) => const Text("SATURSUN", style: TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
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
        ],
      ),
    );
  }

  Widget _buildTrendingJobsSection() {
    return SizedBox(
      height: 180, 
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
        ],
      ),
    );
  }

  Widget _buildTrendingJobCard({
    required String jobTitle,
    required String salary,
    required String note,
    required String recommendation,
    required Color color,
  }) {
    return Container(
      width: 280, 
      padding: const EdgeInsets.all(16),
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
          Text(jobTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(salary, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(width: 5),
              Text(note, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15), 
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(recommendation, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard({required String title, String? deadline}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (deadline != null) ...[
                  const SizedBox(height: 4),
                  Text(deadline, style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.w500)),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _saturSunOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Unggah Portofolio Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.assignment_outlined, size: 40, color: _saturSunOrange.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET NAVIGASI BARU ---
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 5;
    
    // Hitung posisi lingkaran aktif
    final double activePosition = (itemWidth * currentIndex) + (itemWidth / 2) - 28; // 28 adalah setengah dari lebar FAB (56/2)

    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          // Background Bar
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
          
          // Floating Active Indicator (Lingkaran Warna)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            left: activePosition,
            bottom: 20, // Membuatnya melayang sedikit di atas bar
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
              // Ikon aktif (putih)
              child: Icon(
                _getIconForIndex(currentIndex),
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          // Menu Items
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
            // Jika aktif, ikon di bar disembunyikan (karena sudah ada di lingkaran melayang)
            isActive 
              ? const SizedBox(height: 24) 
              : Icon(icon, color: Colors.grey, size: 26),
            if (!isActive)
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}