import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class HomeScreenKlien extends StatefulWidget {
  const HomeScreenKlien({super.key});

  @override
  State<HomeScreenKlien> createState() => _HomeScreenKlienState();
}

class _HomeScreenKlienState extends State<HomeScreenKlien> {
  // Helper format rupiah
  String _formatRupiah(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 0),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
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
                _buildHeader(),
                const SizedBox(height: 24),
                _buildCreateJobButton(),
                const SizedBox(height: 32),

                _buildSectionTitle("Proyek Aktif"),
                const SizedBox(height: 12),
                
                // STREAM BUILDER
                StreamBuilder<QuerySnapshot>(
                  stream: jobService.getClientJobsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        width: double.infinity,
                        decoration: _whiteCardStyle().copyWith(color: Colors.white.withValues(alpha: 0.9)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.assignment_outlined, size: 40, color: Colors.grey[400]),
                              const SizedBox(height: 8),
                              Text(
                                "Belum ada proyek aktif",
                                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return _buildHorizontalList(
                      children: docs.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        
                        int budget = 0;
                        if (data['budget'] != null) {
                           budget = int.tryParse(data['budget'].toString()) ?? 0;
                        }

                        // PASS FULL DATA KE WIDGET CARD
                        return _buildProjectCard(
                          fullData: data, 
                          title: data['title'] ?? 'Tanpa Judul',
                          status: "Open",
                          budget: _formatRupiah(budget),
                        );
                      }).toList(),
                    );
                  },
                ),

                const SizedBox(height: 32),
                _buildSectionTitle("Membutuhkan Tindakan"),
                const SizedBox(height: 12),
                _buildHorizontalList(children: [
                  _buildActionCard(title: "Lihat 5 Pelamar Baru Masuk", subtitle: "Copywriting Promosi Produk", icon: Icons.people),
                  _buildActionCard(title: "Lakukan Pembayaran", subtitle: "Proyek Motion Graphic", icon: Icons.payment),
                ]),

                const SizedBox(height: 32),
                _buildSectionTitle("Statistik Bulan Ini"),
                const SizedBox(height: 12),
                _buildHorizontalList(children: [
                  _buildStatCard(icon: Icons.receipt_long, label: "Pengeluaran Bln Ini", value: "Rp4.500.000"),
                  _buildStatCard(icon: Icons.check_circle, label: "Proyek Selesai", value: "18"),
                  _buildStatCard(icon: Icons.person, label: "Freelancer Aktif", value: "12"),
                ]),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/logo.png", height: 100),
          const SizedBox(height: 1),
          Text("Halo, Saturnfren 👋", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  Widget _buildCreateJobButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GestureDetector(
        onTap: () => context.push('/klien/job-post-first'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Text("+ Posting Pekerjaan Baru", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 17, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 19, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildHorizontalList({required List<Widget> children}) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 22),
          ...children.map((c) => Padding(padding: const EdgeInsets.only(right: 16), child: c)),
        ],
      ),
    );
  }

  // CARD PROYEK: Menambahkan gesture onTap ke Detail
  Widget _buildProjectCard({required Map<String, dynamic> fullData, required String title, required String status, required String budget}) {
    return GestureDetector(
      onTap: () => context.push('/klien/job-detail', extra: fullData), // NAVIGASI DI SINI
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(18),
        decoration: _whiteCardStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("Status: $status", style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(value: 0.1, backgroundColor: Color(0xFFEEEEEE), color: Colors.green, minHeight: 6),
            ),
            const SizedBox(height: 8),
            Text(budget, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: _whiteCardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 30),
          const SizedBox(height: 12),
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required String label, required String value}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(18),
      decoration: _whiteCardStyle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  BoxDecoration _whiteCardStyle() {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 4))],
    );
  }
}