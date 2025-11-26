import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobPostSecondScreenKlien extends StatefulWidget {
  const JobPostSecondScreenKlien({super.key});

  @override
  State<JobPostSecondScreenKlien> createState() => _JobPostSecondScreenKlienState();
}

class _JobPostSecondScreenKlienState extends State<JobPostSecondScreenKlien> {
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _tenggatController = TextEditingController();

  @override
  void dispose() {
    _deskripsiController.dispose();
    _budgetController.dispose();
    _tenggatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          // ============================
          //   GRADIENT BACKGROUND FULL SCREEN
          // ============================
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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ============================
                  // HEADER + BACK BUTTON
                  // ============================
                  _buildHeader(),

                  const SizedBox(height: 24),

                  // ============================
                  // FORM CARD
                  // ============================
                  _buildFormCard(),

                  const SizedBox(height: 32),

                  // ============================
                  // TAMBAH BUTTON
                  // ============================
                  _buildTambahButton(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================
  // HEADER
  // ============================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // REVISI: Satursun Freelance warna putih rata kiri
              Text(
                "Satursun Freelance",
                style: TextStyle(
                  color: Colors.white, // Warna putih
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              // REVISI: Posting Pekerjaan warna hitam
              Text(
                "Posting Pekerjaan",
                style: TextStyle(
                  color: Colors.black, // Warna hitam
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "(Langkah 2/2)",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================
  // FORM CARD
  // ============================
  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DESKRIPSI PEKERJAAN
          _buildDeskripsiField(),

          const SizedBox(height: 20),

          // BUDGET PEKERJAAN
          _buildBudgetField(),

          const SizedBox(height: 20),

          // TENGAT PEKERJAAN
          _buildTenggatField(),
        ],
      ),
    );
  }

  // ============================
  // DESKRIPSI FIELD (TEXTAREA)
  // ============================
  Widget _buildDeskripsiField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deskripsi Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: _deskripsiController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Klien membutuhkan seorang desainer grafis untuk membuat poster acara. Desain harus informatif, memiliki estetika visual yang menarik, serta mudah dibaca.",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  // ============================
  // BUDGET FIELD
  // ============================
  Widget _buildBudgetField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Budget Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "RP 200.000",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.attach_money, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  // ============================
  // TENGAT FIELD
  // ============================
  Widget _buildTenggatField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tenggat Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: _tenggatController,
            decoration: const InputDecoration(
              hintText: "10 Hari",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  // ============================
  // TAMBAH BUTTON (MIRIP LANJUT)
  // ============================
  Widget _buildTambahButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          // ROUTE KEMBALI KE JOB SCREEN
          Navigator.pushNamedAndRemoveUntil(
              context,
              '/job-klien',
                  (Route<dynamic> route) => false
          );
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
              "Tambah",
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
}