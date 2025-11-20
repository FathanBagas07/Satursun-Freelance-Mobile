import 'package:flutter/material.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunRed = Color(0xFFE53935);

class ExploreScreenFreelancer extends StatelessWidget {
  const ExploreScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _saturSunLightBlue,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), 
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _saturSunBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home-freelancer');
        },
      ),
      title: const Text('SaturSun Freelance', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(),
          const SizedBox(height: 20),
          _buildSectionHeader(icon: Icons.star_border, title: 'Rekomendasi untuk Anda', isNew: true),
          
          // --- PERUBAHAN: Navigasi ke Job Detail saat di klik ---
          _buildJobRecommendationCard(context, title: 'Desain Poster Acara', subtitle: 'Cocok dengan keahlian desain grafis', price: 'Rp 75.000'),
          _buildJobRecommendationCard(context, title: 'Asisten Riset Psikologi', subtitle: 'Populer untuk mahasiswa Psikologi', price: 'Rp 60.000'),
          
          const SizedBox(height: 20),
          _buildSectionHeader(icon: Icons.bookmark_outline, title: 'Paket Lainnya', isNew: false),
          _buildPackageCard(title: 'Tutor 3 Mata Kuliah', originalPrice: 'Rp 150.000', discountedPrice: 'Rp 120.000', discount: '20% off'),
          _buildPackageCard(title: 'Tutor 2 Mata Kuliah', originalPrice: 'Rp 120.000', discountedPrice: 'Rp 93.500', discount: '22% off'),
          const SizedBox(height: 80), 
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filter Pintar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Switch(value: true, onChanged: (bool value) {}, activeColor: Colors.white, activeTrackColor: _saturSunOrange, inactiveThumbColor: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          _buildFilterButton(icon: Icons.calendar_today, label: 'Hanya Akhir Pekan', onTap: () {}),
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
    );
  }

  Widget _buildFilterButton({required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isWide = !label.contains(':'); 
    return Material(
      color: isWide ? Colors.white : _saturSunLightBlue,
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
            mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(icon, color: _saturSunBlue, size: 20),
              if (isWide) const SizedBox(width: 10),
              Flexible(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title, required bool isNew}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: _saturSunBlue, size: 24),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          if (isNew) ...[const SizedBox(width: 8), _buildNewTag()],
        ],
      ),
    );
  }

  Widget _buildNewTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: _saturSunOrange, borderRadius: BorderRadius.circular(5)),
      child: const Text('Baru', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  // --- PERUBAHAN: Ditambahkan GestureDetector untuk navigasi ---
  Widget _buildJobRecommendationCard(BuildContext context, {required String title, required String subtitle, required String price}) {
    return GestureDetector(
      onTap: () {
         Navigator.pushNamed(context, '/job-detail');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Flexible(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))), const SizedBox(width: 8), _buildNewTag()]),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _saturSunOrange)),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard({required String title, required String originalPrice, required String discountedPrice, required String discount}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(originalPrice, style: TextStyle(fontSize: 12, color: Colors.grey[500], decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 5),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: _saturSunRed.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(5)), child: Text(discount, style: TextStyle(color: _saturSunRed, fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 4),
              Text(discountedPrice, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _saturSunOrange)),
            ],
          ),
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