import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class WalletScreenKlien extends StatefulWidget {
  const WalletScreenKlien({super.key});

  @override
  State<WalletScreenKlien> createState() => _WalletScreenKlienState();
}

class _WalletScreenKlienState extends State<WalletScreenKlien> {
  // Data pembayaran pekerja (bisa di-scroll vertikal)
  final List<Map<String, dynamic>> _pendingPayments = [
    {
      'name': 'Nowel',
      'project': 'Video Anim Player',
      'amount': 'Rp 200.000',
      'selected': false,
    },
    {
      'name': 'Arya',
      'project': 'UI/UX Design Website',
      'amount': 'Rp 350.000',
      'selected': false,
    },
    {
      'name': 'Sarah',
      'project': 'Mobile App Development',
      'amount': 'Rp 500.000',
      'selected': false,
    },
  ];

  // Data metode pembayaran instan (bisa di-scroll horizontal)
  final List<Map<String, dynamic>> _instantPayments = [
    {'name': 'Dana', 'icon': 'assets/dana_icon.png'},
    {'name': 'gopay', 'icon': 'assets/gopay_icon.png'},
    {'name': 'ovo', 'icon': 'assets/ovo_icon.png'},
  ];

  // Data bank transfer
  String _selectedTransferType = 'Standard (2 hari)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 2),
      body: Stack(
        children: [
          // GRADIENT BACKGROUND FULL SCREEN (SAMA SEPERTI HOME)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF009FFD),
                  Color(0xFFFF7A00),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // HEADER
                _buildHeader(),
                const SizedBox(height: 24),

                // PENGELUARAN BULAN INI CARD
                _buildExpenseCard(),
                const SizedBox(height: 24),

                // DANA PROYEK BERJALAN
                _buildProjectFundsCard(),
                const SizedBox(height: 24),

                // PEMBAYARAN PEKERJA SECTION
                _buildPaymentSection(),
                const SizedBox(height: 24),

                // PEMBAYARAN INSTAN SECTION
                _buildInstantPaymentSection(),
                const SizedBox(height: 24),

                // BANK TRANSFER SECTION
                _buildBankTransferSection(),
                const SizedBox(height: 24),

                // BAYAR SEKARANG BUTTON
                _buildPayNowButton(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          // UPDATE: Menambahkan tombol Back Arrow dengan logika navigasi ke Home
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/home-klien', (route) => false),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet - Klien",
                style: TextStyle(
                  fontSize: 22, // Sedikit disesuaikan agar proporsional dengan icon
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Satursun Freelance",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CARD: PENGELUARAN BULAN INI
  Widget _buildExpenseCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _whiteCardStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pengeluaran Bulan ini",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Mei 2025",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  "Rp 4.500.000",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_upward,
                          color: Colors.green, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "12% vs bulan lalu",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // CARD: DANA PROYEK BERJALAN
  Widget _buildProjectFundsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _whiteCardStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dana Proyek Berjalan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Rp 290.000",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECTION: PEMBAYARAN PEKERJA
  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pembayaran Pekerja",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // LOGIKA: Container dengan fixed height untuk scroll vertikal terbatas
          Container(
            height: 200, // BATASAN TINGGI SCROLL VERTIKAL
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _pendingPayments.length,
              itemBuilder: (context, index) {
                return _buildPaymentItem(_pendingPayments[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ITEM: PEMBAYARAN PEKERJA
  Widget _buildPaymentItem(Map<String, dynamic> payment, int index) {
    return Container(
      margin: EdgeInsets.only(
          bottom: index == _pendingPayments.length - 1 ? 0 : 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: payment['selected'] == true
              ? const Color(0xFFFF7A00)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Checkbox untuk seleksi
          GestureDetector(
            onTap: () {
              setState(() {
                _pendingPayments[index]['selected'] =
                    !_pendingPayments[index]['selected'];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: payment['selected'] == true
                    ? const Color(0xFFFF7A00)
                    : Colors.grey[300],
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: payment['selected'] == true
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Proyek : ${payment['project']}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Rp : ${payment['amount']}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Pilih",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFFF7A00),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // SECTION: PEMBAYARAN INSTAN
  Widget _buildInstantPaymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pembayaran Instan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // LOGIKA: Horizontal scroll untuk metode pembayaran instan
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _instantPayments.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(
                    right: index == _instantPayments.length - 1 ? 0 : 12,
                  ),
                  child: _buildInstantPaymentItem(_instantPayments[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Rp 2.500/transaksi",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ITEM: PEMBAYARAN INSTAN
  Widget _buildInstantPaymentItem(Map<String, dynamic> payment) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            payment['icon'],
            height: 30,
            errorBuilder: (c, e, s) =>
                const Icon(Icons.payment, size: 30, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            payment['name'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // SECTION: BANK TRANSFER
  Widget _buildBankTransferSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bank Transfer",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // Pilih Bank Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "pilih bank >",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Pilihan Transfer Type
          Row(
            children: [
              Expanded(
                child: _buildTransferTypeOption(
                  "Standard (2 hari)",
                  _selectedTransferType == "Standard (2 hari)",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTransferTypeOption(
                  "Express (1 jam)",
                  _selectedTransferType == "Express (1 jam)",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // OPTION: TRANSFER TYPE
  Widget _buildTransferTypeOption(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTransferType = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              const Icon(Icons.check_circle, color: Colors.green, size: 18),
            ],
          ],
        ),
      ),
    );
  }

  // BUTTON: BAYAR SEKARANG
  Widget _buildPayNowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GestureDetector(
        onTap: () {
          // Logic untuk proses pembayaran
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A00),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "Bayar Sekarang",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // REUSABLE WHITE CARD STYLE (SAMA DENGAN HOME)
  BoxDecoration _whiteCardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}