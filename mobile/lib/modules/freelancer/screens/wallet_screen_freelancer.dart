import 'package:flutter/material.dart';

// Definisi warna yang digunakan (lanjutan dari file sebelumnya)
const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunGreen = Color(0xFF4CAF50); // Untuk indikator naik

class WalletScreenFreelancer extends StatelessWidget {
  const WalletScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang utama menggunakan gradient seperti di gambar
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
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Bottom navigation bar dibuat terpisah, fokus pada index 2 (Dompet)
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }

  // --- AppBar & Body Konten Utama ---
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Saldo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),
          // --- Saldo Card ---
          _buildBalanceCard(),
          const SizedBox(height: 25),

          // --- Tarik Sekarang Section ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Tarik Sekarang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildWithdrawalCard(),
          const SizedBox(height: 25),

          // --- Hadiah Section ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Hadiah',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildRewardsCard(),
          const SizedBox(height: 100), // Jarak untuk BottomNavBar
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
                Navigator.pop(context); // Aksi kembali
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

  // --- Saldo Card ---
  Widget _buildBalanceCard() {
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
            'Penghasilan Mei 2025',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Rp 1.250.000',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _saturSunBlue,
                ),
              ),
              const SizedBox(width: 8),
              // Indikator persentase
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: _saturSunGreen, size: 16),
                  const Text(
                    '12% vs bulan lalu',
                    style: TextStyle(
                      color: _saturSunGreen,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Komisi Tertahan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // Progress Bar Komisi
          LinearProgressIndicator(
            value: 0.7, // Contoh 70%
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange),
            minHeight: 5,
          ),
          const SizedBox(height: 5),
          const Text(
            'Akan cair setelah job selesai',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // --- Tarik Sekarang Card ---
  Widget _buildWithdrawalCard() {
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
            'Pembayaran Instan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Daftar E-Wallet/Pembayaran Instan
          Row(
            children: [
              _buildEWalletIcon('DANA', Colors.blue),
              const SizedBox(width: 10),
              _buildEWalletIcon('gopay', Colors.green),
              const SizedBox(width: 10),
              _buildEWalletIcon('OVO', Colors.purple),
              const SizedBox(width: 10),
              // Tambahan (misal: ShopeePay)
              _buildEWalletIcon('...', Colors.grey),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Rp 2.500/transaksi',
            style: TextStyle(
              fontSize: 12,
              color: _saturSunOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(height: 30),
          // Bank Transfer Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bank Transfer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'pilih bank >',
                  style: TextStyle(
                    fontSize: 14,
                    color: _saturSunBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildTransferOption('Standar (2 hari)', isSelected: true),
              const SizedBox(width: 15),
              _buildTransferOption('Kilat (1 jam)', isSelected: false),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk E-Wallet
  Widget _buildEWalletIcon(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Widget untuk Opsi Transfer (Standar/Kilat)
  Widget _buildTransferOption(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? _saturSunLightBlue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? _saturSunGreen : Colors.grey,
            size: 18,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? _saturSunBlue : Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // --- Hadiah Card ---
  Widget _buildRewardsCard() {
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
            'Kupon',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildCouponItem(
            'Kerjakan 20 job (Kupon Skill Academy 40K)',
            current: 3,
            target: 20,
          ),
          _buildCouponItem(
            'Kerjakan 15 job (Voucher)',
            current: 5,
            target: 15,
          ),
        ],
      ),
    );
  }

  // Widget untuk Item Kupon
  Widget _buildCouponItem(String description,
      {required int current, required int target}) {
    double progress = current / target;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                '$current/$target',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: progress >= 1.0 ? _saturSunGreen : _saturSunOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange),
            minHeight: 5,
          ),
        ],
      ),
    );
  }
}

// --- Bottom Navigation Bar (Disesuaikan dengan index 2: Dompet) ---
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
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
            selectedItemColor: _saturSunBlue,
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
                      padding: EdgeInsets.only(top: 8), child: Icon(null)),
                  label: 'Dompet'), // Placeholder untuk ikon tengah
              BottomNavigationBarItem(
                  icon: Icon(Icons.help_outline), label: 'Bantuan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Profil'),
            ],
            onTap: (index) {
              // Handle navigasi
            },
          ),
          // Floating Middle Icon (Dompet)
          Positioned(
            bottom: 10,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: _saturSunOrange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: _saturSunOrange.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
              ),
              child: const Icon(Icons.shopping_bag, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}