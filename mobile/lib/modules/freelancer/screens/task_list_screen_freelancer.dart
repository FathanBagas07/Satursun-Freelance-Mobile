import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunGreen = Color(0xFF4CAF50); 
const Color _saturSunYellow = Color(0xFFFFC107); 

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  String _formatRupiah(dynamic price) {
    if (price == null) return "Rp 0";
    String priceStr = price.toString();
    String cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return "Rp ${cleanPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.onPrimary, Theme.of(context).colorScheme.secondary],
                stops: const [0.0, 0.3, 0.9],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3), // Pastikan index benar (biasanya 2 atau 3)
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildFilterButton(context, icon: Icons.calendar_today, label: 'Semua Pekerjaan', onTap: () {}),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: _buildFilterButton(context, icon: Icons.location_on, label: 'Lokasi: USU Medan', onTap: () {})),
                    const SizedBox(width: 10),
                    Expanded(child: _buildFilterButton(context, icon: Icons.account_balance_wallet_outlined, label: 'Harga: Rp 25k - 100k', onTap: () {})),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // === HEADER TUGAS AKTIF ===
          _buildTaskHeader(context, 'Tugas Aktif'),

          // === STREAM BUILDER ===
          StreamBuilder<QuerySnapshot>(
            stream: jobService.getFreelancerTasksStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: const Center(child: Text("Belum ada tugas aktif")),
                );
              }

              final docs = snapshot.data!.docs;

              return Column(
                children: docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final status = data['status'] ?? 'Active';
                  
                  // Hanya tampilkan yang Active di section ini
                  if (status != 'Active') return const SizedBox.shrink();

                  return _buildTaskCard(
                    context, 
                    title: data['title'] ?? 'Tanpa Judul', 
                    subTitle: 'Proyek Berjalan', 
                    price: _formatRupiah(data['budget']), 
                    progress: 0.0, 
                    progressLabel: '0% Selesai', 
                    isComplete: false
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 30),
          
          // TUGAS SELESAI (Masih Dummy dulu)
          _buildTaskHeader(context, 'Tugas Selesai'),
          _buildTaskCard(context, title: 'Editing Video Dokumentasi', subTitle: 'IMILKOM', price: 'Rp 75.000', progress: 1.0, progressLabel: '100% Selesai', isComplete: true),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface), onPressed: () { context.go('/freelancer/home'); }),
                Text('SaturSun Freelance', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.surface)),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 20.0, top: 5), child: Text('Daftar Tugas', style: textTheme.displayMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isWide = !label.contains(':');
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: isWide ? Border.all(color: Colors.grey[300]!) : null),
          child: Row(mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center, children: [Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20), if (isWide) const SizedBox(width: 10), Flexible(child: Text(label, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis))]),
        ),
      ),
    );
  }

  Widget _buildTaskHeader(BuildContext context, String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5), child: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)));
  }

  Widget _buildTaskCard(BuildContext context, {required String title, required String subTitle, required String price, required double progress, required String progressLabel, required bool isComplete}) {
    final Color detailColor = isComplete ? _saturSunGreen : Theme.of(context).colorScheme.error;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(subTitle, style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey[600]))])),
              const SizedBox(width: 10),
              Text(price, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: isComplete ? _saturSunGreen : Theme.of(context).colorScheme.secondary)),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunYellow), minHeight: 5)), 
            const SizedBox(width: 10), 
            Text(progressLabel, style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)), 
            const SizedBox(width: 15), 
            GestureDetector(
              onTap: () { 
                context.push('/freelancer/task-submission'); 
              }, 
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                decoration: BoxDecoration(color: detailColor, borderRadius: BorderRadius.circular(5)), 
                child: Text('Detail', style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 12, fontWeight: FontWeight.bold))
              )
            )
          ]),
        ],
      ),
    );
  }
}