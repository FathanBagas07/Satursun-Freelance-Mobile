import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class HomeScreenFreelancer extends StatelessWidget {
  const HomeScreenFreelancer({super.key});

  // Helper untuk format rupiah
  String _formatRupiah(dynamic amount) {
    if (amount == null) return 'Rp 0';
    double val = 0;
    if (amount is int) val = amount.toDouble();
    if (amount is double) val = amount;
    if (amount is String) val = double.tryParse(amount) ?? 0;
    
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigasi Bar tetap di bawah
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      
      // Menggunakan Stack seperti di HomeScreenKlien (Sesuai Request Anda)
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // Menggunakan warna yang sama dengan Klien (Primary -> Secondary)
                colors: [
                  Theme.of(context).colorScheme.primary, 
                  Theme.of(context).colorScheme.secondary
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              // Padding bawah besar agar konten tidak tertutup Nav Bar saat di-scroll mentok
              padding: const EdgeInsets.only(bottom: 120), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 100,
                          errorBuilder: (c, e, s) => Text(
                            "SATURSUN",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Halo, Saturfren!',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // Menggunakan onSurface agar kontras tetap terjaga
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // --- Judul Section ---
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Trending Weekend Jobs',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // Mengubah warna jadi putih agar terlihat di background gradient
                        // Atau gunakan onSurface jika background di area ini tertutup container putih
                        color: Colors.black, 
                      ),
                    ),
                  ),
                  
                  // --- List Horizontal (DATA DARI FIREBASE) ---
                  const SizedBox(height: 10),
                  _buildTrendingJobsSection(context),
                  
                  // --- List Vertical (Job Cards Static - Sesuai Desain Awal) ---
                  const SizedBox(height: 20),
                  Padding(
                     padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                     child: Text("Rekomendasi Lainnya", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  _buildJobCard(
                    context,
                    title: 'Tutor Coding ASAP - Bayaran 2x',
                    deadline: null,
                  ),
                  const SizedBox(height: 15),
                  _buildJobCard(
                    context,
                    title: 'Desain Logo Event',
                    deadline: 'Deadline jam 23.59 WIB',
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- BAGIAN INI YANG DIUBAH LOGIKANYA ---
  Widget _buildTrendingJobsSection(BuildContext context) {
    return SizedBox(
      height: 180,
      child: StreamBuilder<QuerySnapshot>(
        // Mengambil data jobs dari Firebase
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('status', isEqualTo: 'Open')
            .snapshots(),
        builder: (context, snapshot) {
          // Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          // Empty State
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Text("Belum ada proyek trending")),
            );
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              data['id'] = docs[index].id; // Simpan ID

              // Variasi warna kartu
              Color cardColor = index % 2 == 0 
                  ? Theme.of(context).colorScheme.secondary 
                  : Theme.of(context).colorScheme.primary;

              return Padding(
                padding: const EdgeInsets.only(right: 15), // Jarak antar kartu
                child: _buildTrendingJobCard(
                  context,
                  data: data, // Pass data untuk navigasi
                  jobTitle: data['title'] ?? 'Tanpa Judul',
                  salary: _formatRupiah(data['budget']),
                  note: '', // Bisa diisi jika ada field note
                  recommendation: data['category'] ?? 'Umum',
                  color: cardColor,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTrendingJobCard(
    BuildContext context, {
    required Map<String, dynamic> data, // Tambahan parameter data
    required String jobTitle,
    required String salary,
    required String note,
    required String recommendation,
    required Color color,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      // Navigasi ke detail saat kartu diklik
      onTap: () => context.push('/freelancer/job-detail', extra: data),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, // Kartu tetap putih/surface
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jobTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(salary,
                    style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                const SizedBox(width: 5),
                Text(note, style: textTheme.bodyMedium!.copyWith(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(recommendation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, {required String title, String? deadline}) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                if (deadline != null) ...[
                  const SizedBox(height: 4),
                  Text(deadline,
                      style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.w500)),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text('Unggah Portofolio Sekarang',
                      style: textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.assignment_outlined, size: 40, color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}