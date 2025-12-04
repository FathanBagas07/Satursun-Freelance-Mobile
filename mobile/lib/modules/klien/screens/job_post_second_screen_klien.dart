import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Pastikan package http sudah diinstall
import 'dart:convert'; // Untuk jsonEncode

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

  bool _isLoading = false;
  Map<String, dynamic>? firstScreenData;

  // Mengambil data argumen dari screen sebelumnya
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      firstScreenData = args;
    }
  }

  // Fungsi untuk Memposting Pekerjaan ke Database
  Future<void> _postJob() async {
    // 1. Validasi Input Screen 2
    if (_deskripsiController.text.isEmpty ||
        _budgetController.text.isEmpty ||
        _tenggatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap lengkapi deskripsi, budget, dan tenggat waktu!")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 2. Konfigurasi API (Ganti URL sesuai IP laptop Anda)
    // Emulator Android: 10.0.2.2 | Device Fisik: 192.168.x.x
    const String apiUrl = "http://10.0.2.2:8000/api/jobs";
    
    // TODO: Ganti ini dengan token asli dari SharedPreferences setelah login
    const String token = "TOKEN_SEMENTARA_DARI_LOGIN"; 

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "judul": firstScreenData?['judul'],
          "lokasi": firstScreenData?['lokasi'],
          "kategori": firstScreenData?['kategori'],
          "deskripsi": _deskripsiController.text,
          "budget": int.tryParse(_budgetController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0, // Hanya ambil angka
          "tenggat_waktu": _tenggatController.text,
        }),
      );

      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pekerjaan berhasil diposting!")),
          );
          // Kembali ke halaman utama job dan hapus history
          Navigator.pushNamedAndRemoveUntil(
              context, '/job-klien', (Route<dynamic> route) => false);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Gagal: ${response.body}")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Terjadi kesalahan koneksi: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
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
                  // TAMBAH BUTTON (Loading State)
                  // ============================
                  _isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : _buildTambahButton(),

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
            child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Satursun Freelance",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Posting Pekerjaan",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "(Langkah 2/2)",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
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
        Text(
          "Deskripsi Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
        Text(
          "Budget Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
              hintText: "200000",
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
        Text(
          "Tenggat Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
  // TAMBAH BUTTON (UPDATED)
  // ============================
  Widget _buildTambahButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _postJob, // Panggil fungsi API
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "Tambah",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
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