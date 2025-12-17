import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class JobDetailScreen extends StatefulWidget {
  final Map<String, dynamic> jobData;

  const JobDetailScreen({super.key, required this.jobData});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  bool _isLoading = false;
  bool _hasTaken = false; // Status apakah sudah diambil
  bool _isChecking = true; // Status loading pengecekan awal

  @override
  void initState() {
    super.initState();
    _checkJobStatus();
  }

  // Cek ke Firebase apakah user sudah mengambil job ini
  Future<void> _checkJobStatus() async {
    final jobId = widget.jobData['id'];
    if (jobId != null) {
      final taken = await jobService.isJobTaken(jobId);
      if (mounted) {
        setState(() {
          _hasTaken = taken;
          _isChecking = false;
        });
      }
    } else {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  // Fungsi Logika Tombol Kerjakan
  Future<void> _handleStartJob() async {
    setState(() => _isLoading = true);
    try {
      final jobId = widget.jobData['id'];
      if (jobId == null) throw Exception("ID Pekerjaan tidak valid");

      await jobService.startJob(jobId, widget.jobData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil mengambil pekerjaan!")),
      );

      context.go('/freelancer/tasks'); 

    } catch (e) {
      if (mounted) {
        // Tampilkan pesan error yang user-friendly
        String message = "Gagal mengambil pekerjaan";
        if (e.toString().contains("sudah Anda ambil")) {
          message = "Anda sudah mengambil pekerjaan ini sebelumnya.";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _formatRupiah(dynamic price) {
    if (price == null) return "Rp 0";
    String priceStr = price.toString();
    String cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return "Rp ${cleanPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.jobData;
    final title = data['title'] ?? 'Tanpa Judul';
    final desc = data['description'] ?? 'Tidak ada deskripsi.';
    final budget = _formatRupiah(data['budget']);
    final deadline = data['deadline'] ?? '-';
    final category = data['category'] ?? 'Umum';
    final location = data['location'] ?? '-'; // Ambil lokasi dari data
    
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.onPrimary],
                stops: const [0.0, 0.25],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$category :', style: textTheme.bodyMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                      const SizedBox(height: 4),
                      Text(title, style: textTheme.headlineMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 4),
                      Text(
                        'Lokasi : $location', // Tampilkan lokasi dinamis
                        style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildInfoCard(context, Icons.calendar_today, 'Tenggat :', deadline)),
                          const SizedBox(width: 15),
                          Expanded(child: _buildInfoCard(context, Icons.payment, 'Bayaran :', budget, Theme.of(context).colorScheme.secondary)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deskripsi Pekerjaan', style: textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      Text(desc, style: textTheme.bodyMedium!.copyWith(fontSize: 15, height: 1.4)),
                      const SizedBox(height: 15),
                      Text('Keahlian yang Dibutuhkan', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildBulletPoint(context, 'Sesuai Deskripsi Pekerjaan'),
                      _buildBulletPoint(context, 'Profesional dan Tepat Waktu'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      
      // === LOGIKA TOMBOL ===
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity, height: 55,
          child: _isChecking
              // Loading saat cek status
              ? const Center(child: CircularProgressIndicator()) 
              : ElevatedButton(
                  // Jika sudah diambil (_hasTaken), tombol disable (null) atau pindah halaman
                  // Jika _isLoading (sedang proses save), tombol disable
                  onPressed: (_hasTaken || _isLoading) 
                      ? (_hasTaken ? () => context.go('/freelancer/tasks') : null) 
                      : _handleStartJob,
                  style: ElevatedButton.styleFrom(
                    // Warna abu jika sudah diambil, Merah jika belum
                    backgroundColor: _hasTaken ? Colors.grey : Theme.of(context).colorScheme.error,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        _hasTaken ? 'Sudah Diambil (Lihat Tugas)' : 'Kerjakan',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => context.pop()),
            const Text("Detail Lowongan", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String label, String value, [Color valueColor = Colors.black]) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20), const SizedBox(width: 8), Text(label, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54))]),
          const SizedBox(height: 8),
          Text(value, style: textTheme.displaySmall!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('• ', style: textTheme.bodyMedium!.copyWith(fontSize: 15)), Expanded(child: Text(text, style: textTheme.bodyMedium!.copyWith(fontSize: 15, height: 1.4)))]),
    );
  }
}