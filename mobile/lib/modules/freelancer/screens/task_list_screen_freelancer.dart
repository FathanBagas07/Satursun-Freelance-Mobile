import 'package:flutter/material.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunGreen = Color(0xFF4CAF50); 
const Color _saturSunRed = Color(0xFFE53935); 
const Color _saturSunYellow = Color(0xFFFFC107); 

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_saturSunBlue, _saturSunLightBlue, _saturSunOrange],
                stops: [0.0, 0.3, 0.9],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildFilterButton(icon: Icons.calendar_today, label: 'Semua Pekerjaan', onTap: () {}),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: _buildFilterButton(icon: Icons.location_on, label: 'Lokasi: USU Medan', onTap: () {})),
                    const SizedBox(width: 10),
                    Expanded(child: _buildFilterButton(icon: Icons.account_balance_wallet_outlined, label: 'Harga: Rp 25k - 100k', onTap: () {})),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildTaskHeader('Tugas Aktif'),
          _buildTaskCard(context, title: 'Desain Poster Event Kampus', subTitle: 'Bem Fasilkom-TI', price: 'Rp 75.000', progress: 0.3, progressLabel: '30% Selesai', isComplete: false),
          const SizedBox(height: 30),
          _buildTaskHeader('Tugas Selesai'),
          _buildTaskCard(context, title: 'Editing Video Dokumentasi', subTitle: 'IMILKOM', price: 'Rp 75.000', progress: 1.0, progressLabel: '100% Selesai', isComplete: true),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () { Navigator.pushReplacementNamed(context, '/home-freelancer'); }),
                const Text('SaturSun Freelance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(left: 20.0, top: 5), child: Text('Daftar Tugas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton({required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isWide = !label.contains(':');
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: isWide ? Border.all(color: Colors.grey[300]!) : null),
          child: Row(mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center, children: [Icon(icon, color: _saturSunBlue, size: 20), if (isWide) const SizedBox(width: 10), Flexible(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis))]),
        ),
      ),
    );
  }

  Widget _buildTaskHeader(String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5), child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)));
  }

  Widget _buildTaskCard(BuildContext context, {required String title, required String subTitle, required String price, required double progress, required String progressLabel, required bool isComplete}) {
    final Color detailColor = isComplete ? _saturSunGreen : _saturSunRed;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(subTitle, style: TextStyle(fontSize: 14, color: Colors.grey[600]))])),
              const SizedBox(width: 10),
              Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isComplete ? _saturSunGreen : _saturSunOrange)),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunYellow), minHeight: 5)), 
            const SizedBox(width: 10), 
            Text(progressLabel, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)), 
            const SizedBox(width: 15), 
            
            // --- PERUBAHAN: Navigasi ke Submission jika Tugas Aktif ---
            GestureDetector(
              onTap: () { 
                // Jika tugas selesai, mungkin ke detail lain, jika aktif ke submission
                // Di sini kita arahkan ke Submission sesuai request
                Navigator.pushNamed(context, '/task-submission'); 
              }, 
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                decoration: BoxDecoration(color: detailColor, borderRadius: BorderRadius.circular(5)), 
                child: const Text('Detail', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
              )
            )
          ]),
        ],
      ),
    );
  }
}

// --- Custom Bottom Nav Bar ---
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
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
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
                boxShadow: [BoxShadow(color: _saturSunOrange.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Icon(_getIconForIndex(currentIndex), color: Colors.white, size: 30),
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