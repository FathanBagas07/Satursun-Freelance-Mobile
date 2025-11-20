import 'package:flutter/material.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunGreen = Color(0xFF4CAF50);

class WalletScreenFreelancer extends StatelessWidget {
  const WalletScreenFreelancer({super.key});

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
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Saldo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 15),
          _buildBalanceCard(),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Tarik Sekarang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const SizedBox(height: 15),
          _buildWithdrawalCard(),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Hadiah', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const SizedBox(height: 15),
          _buildRewardsCard(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                 Navigator.pushReplacementNamed(context, '/home-freelancer');
              },
            ),
            const Text('SaturSun Freelance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Penghasilan Mei 2025', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Rp 1.250.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _saturSunBlue)),
              const SizedBox(width: 8),
              Row(children: [Icon(Icons.arrow_upward, color: _saturSunGreen, size: 16), const Text('12% vs bulan lalu', style: TextStyle(color: _saturSunGreen, fontSize: 14))]),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Komisi Tertahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
          const SizedBox(height: 5),
          const Text('Akan cair setelah job selesai', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWithdrawalCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pembayaran Instan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [_buildEWalletIcon('DANA', Colors.blue), const SizedBox(width: 10), _buildEWalletIcon('gopay', Colors.green), const SizedBox(width: 10), _buildEWalletIcon('OVO', Colors.purple), const SizedBox(width: 10), _buildEWalletIcon('...', Colors.grey)]),
          const SizedBox(height: 5),
          const Text('Rp 2.500/transaksi', style: TextStyle(fontSize: 12, color: _saturSunOrange, fontWeight: FontWeight.w600)),
          const Divider(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Bank Transfer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), GestureDetector(onTap: () {}, child: const Text('pilih bank >', style: TextStyle(fontSize: 14, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const SizedBox(height: 10),
          Row(children: [_buildTransferOption('Standar (2 hari)', isSelected: true), const SizedBox(width: 15), _buildTransferOption('Kilat (1 jam)', isSelected: false)]),
        ],
      ),
    );
  }

  Widget _buildEWalletIcon(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14))),
    );
  }

  Widget _buildTransferOption(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: isSelected ? _saturSunLightBlue : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? _saturSunGreen : Colors.grey, size: 18), const SizedBox(width: 5), Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? _saturSunBlue : Colors.grey[700], fontSize: 13))]),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kupon', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildCouponItem('Kerjakan 20 job (Kupon Skill Academy 40K)', current: 3, target: 20),
          _buildCouponItem('Kerjakan 15 job (Voucher)', current: 5, target: 15),
        ],
      ),
    );
  }

  Widget _buildCouponItem(String description, {required int current, required int target}) {
    double progress = current / target;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Flexible(child: Text(description, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))), Text('$current/$target', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: progress >= 1.0 ? _saturSunGreen : _saturSunOrange))]),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
        ],
      ),
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