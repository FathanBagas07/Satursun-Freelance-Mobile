import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobScreenKlien extends StatefulWidget {
  const JobScreenKlien({super.key});

  @override
  State<JobScreenKlien> createState() => _JobScreenKlienState();
}

class _JobScreenKlienState extends State<JobScreenKlien> {
  String _formatRupiah(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          Container(
            height: 240,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF009FFD), Color(0xFF00A3FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildFilterCard(),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Pekerjaan Aktif", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  ),
                  const SizedBox(height: 12),

                  StreamBuilder<QuerySnapshot>(
                    stream: jobService.getClientJobsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                      
                      if (snapshot.hasError) {
                        return Padding(padding: const EdgeInsets.all(20), child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Center(child: Text("Belum ada pekerjaan aktif", style: TextStyle(color: Colors.grey[600]))),
                        );
                      }

                      final docs = snapshot.data!.docs;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            
                            int budget = 0;
                            if (data['budget'] != null) {
                              budget = int.tryParse(data['budget'].toString()) ?? 0;
                            }

                            return _buildJobItem(
                              fullData: data, // Pass full data
                              title: data['title'] ?? 'Tanpa Judul',
                              description: data['description'] ?? '-',
                              price: _formatRupiah(budget),
                              isActive: true,
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  _buildPostJobButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(onTap: () => context.go('/klien/home'), child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Satursun Freelance", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 22, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text("Posting Pekerjaan", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), 
          _buildFilterField(icon: Icons.work_outline, label: "Semua Pekerjaan"),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _buildFilterField(icon: Icons.location_on_outlined, label: "Lokasi:\nUSU Medan")),
              const SizedBox(width: 12),
              Expanded(child: _buildFilterField(icon: Icons.attach_money_outlined, label: "Harga:\nRp 25k - 100k")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterField({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: Theme.of(context).colorScheme.onSurface)),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface))),
        ],
      ),
    );
  }

  Widget _buildJobItem({required Map<String, dynamic> fullData, required String title, required String description, required String price, required bool isActive}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 3))],
        border: Border.all(color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(price, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => context.push('/klien/job-detail', extra: fullData), // NAVIGASI DI SINI
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
              child: Text("Detail", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPostJobButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => context.push('/klien/job-post-first'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text("+ Posting Pekerjaan Baru", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 17, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}