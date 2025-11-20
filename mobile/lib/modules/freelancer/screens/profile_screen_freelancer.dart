import 'package:flutter/material.dart';

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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_saturSunBlue, _saturSunLightBlue, _saturSunOrange],
                stops: [0.0, 0.35, 0.9],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          _buildPortfolioCard(),
          const SizedBox(height: 20),
          _buildStudyModeCard(),
          const SizedBox(height: 20),
          _buildTaskListSection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

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
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () { Navigator.pushReplacementNamed(context, '/home-freelancer'); }),
                const Text('SaturSun Freelance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.white, backgroundImage: const AssetImage('assets/profile_pic.png'), child: const SizedBox.shrink()),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Monica Raquella', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Freelance Teknik | 4.8 (32 reviews)', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8), fontWeight: FontWeight.w500)),
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

  Widget _buildPortfolioCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Row(children: [Icon(Icons.work_outline, color: Colors.black, size: 24), SizedBox(width: 8), Text('Portofolio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]), GestureDetector(onTap: () {}, child: const Text('Edit', style: TextStyle(fontSize: 16, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const SizedBox(height: 15),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(15)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.cloud_upload_outlined, color: _saturSunBlue, size: 28), const SizedBox(width: 10), Text('Upload karya (max 5MB)', style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w500))])),
        ],
      ),
    );
  }

  Widget _buildStudyModeCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Row(children: [Icon(Icons.brightness_1, color: _saturSunOrange, size: 14), SizedBox(width: 8), Text('Mode Kuliah', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]), Switch(value: true, onChanged: (bool value) {}, activeThumbColor: Colors.white, activeTrackColor: _saturSunOrange, inactiveThumbColor: Colors.grey)]),
          const SizedBox(height: 5),
          Text('Auto-reply: "Sedang ujian, akan dibalas secepatnya"', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildPlaceholderImage(1), _buildPlaceholderImage(2), _buildPlaceholderImage(3)]),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(int index) {
    return Container(width: 70, height: 70, color: _saturSunLightBlue.withValues(alpha: 0.5), child: Center(child: Text('Ilustrasi $index', style: const TextStyle(fontSize: 10, color: _saturSunBlue))));
  }

  Widget _buildTaskListSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Row(children: [Icon(Icons.assignment_outlined, color: Colors.black, size: 24), SizedBox(width: 8), Text('Daftar Tugas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]), GestureDetector(onTap: () {}, child: const Text('Lihat Semua', style: TextStyle(fontSize: 16, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const Divider(height: 30),
          _buildTaskItem(title: 'Desain Poster Event Kampus', subTitle: 'Bem Fasilkom-TI', progress: 0.3, progressLabel: '30% Selesai'),
          const Divider(height: 30),
          _buildTaskItem(title: 'Editing Video Dokumentasi', subTitle: 'Dikerjakan oleh : Arya', progress: 0.7, progressLabel: '70% Selesai'),
        ],
      ),
    );
  }

  Widget _buildTaskItem({required String title, required String subTitle, required double progress, required String progressLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subTitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Progress', style: TextStyle(fontSize: 12, color: Colors.black54)), Text(progressLabel, style: TextStyle(fontSize: 12, color: progress < 1.0 ? _saturSunOrange : _saturSunBlue, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
      ],
    );
  }
}

// --- DUPLIKASI WIDGET NAVIGASI ---
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
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2))],
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
                boxShadow: [BoxShadow(color: _saturSunOrange.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))],
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