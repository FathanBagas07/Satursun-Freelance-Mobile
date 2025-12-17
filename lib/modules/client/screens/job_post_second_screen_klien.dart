import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobPostSecondScreenKlien extends StatefulWidget {
  final Map<String, dynamic> dataAwal; // Menerima data dari screen 1
  const JobPostSecondScreenKlien({super.key, required this.dataAwal});

  @override
  State<JobPostSecondScreenKlien> createState() => _JobPostSecondScreenKlienState();
}

class _JobPostSecondScreenKlienState extends State<JobPostSecondScreenKlien> {
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _tenggatController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handlePostJob() async {
    setState(() => _isLoading = true);
    try {
      // Bersihkan Rp dan titik dari budget untuk disimpan sebagai angka
      String cleanBudget = _budgetController.text.replaceAll(RegExp(r'[^0-9]'), '');
      int budgetValue = int.tryParse(cleanBudget) ?? 0;

      final fullData = {
        ...widget.dataAwal,
        'description': _deskripsiController.text,
        'budget': budgetValue, // Simpan sebagai angka
        'deadline': _tenggatController.text,
      };

      await jobService.createJob(fullData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pekerjaan Berhasil Dibuat")));
      
      // Kembali ke halaman Job Screen
      context.go('/klien/job'); 

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          Container(
            width: double.infinity, height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildFormCard(),
                  const SizedBox(height: 32),
                  _buildTambahButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(onTap: () => context.pop(), child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Satursun Freelance", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 22, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text("Posting Pekerjaan", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text("(Langkah 2/2)", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(26)),
      child: Column(
        children: [
          _buildField("Deskripsi Pekerjaan", _deskripsiController, maxLines: 5, hint: "Jelaskan detail..."),
          const SizedBox(height: 20),
          _buildField("Bayaran Pekerjaan", _budgetController, hint: "Rp 200.000", isNumber: true, icon: Icons.attach_money),
          const SizedBox(height: 20),
          _buildField("Tenggat Pekerjaan", _tenggatController, hint: "10 Hari", icon: Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1, String? hint, bool isNumber = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
          child: TextField(
            controller: controller, maxLines: maxLines, keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, icon: icon != null ? Icon(icon, color: Colors.grey) : null),
          ),
        ),
      ],
    );
  }

  // TOMBOL TAMBAH (SAVE & NAVIGATE)
  Widget _buildTambahButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _isLoading ? null : _handlePostJob,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text("Tambah", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 17, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}