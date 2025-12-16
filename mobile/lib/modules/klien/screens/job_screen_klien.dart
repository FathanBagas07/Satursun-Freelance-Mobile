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
  // 1. Variabel untuk menyimpan kata kunci pencarian
  String _searchTitle = "";
  String _searchLocation = "";
  String _searchPrice = "";

  String _formatRupiah(int price) {
    return "Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          // Background Gradient
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
                  
                  // 2. Filter Card sekarang interaktif
                  _buildFilterCard(),
                  
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Pekerjaan Aktif", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)
                    ),
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

                      // 3. Logika Filter Data
                      var docs = snapshot.data!.docs;
                      
                      // Filter list berdasarkan input user
                      final filteredDocs = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        
                        // Ambil data (handle null safety)
                        String title = (data['title'] ?? '').toString().toLowerCase();
                        String location = (data['location'] ?? '').toString().toLowerCase();
                        int budget = int.tryParse(data['budget'].toString()) ?? 0;

                        // Cek kecocokan (Case Insensitive)
                        bool matchTitle = title.contains(_searchTitle.toLowerCase());
                        bool matchLocation = location.contains(_searchLocation.toLowerCase());
                        
                        // Filter Harga: Jika user input angka, cari budget yang >= input user
                        bool matchPrice = true;
                        if (_searchPrice.isNotEmpty) {
                          int? filterPrice = int.tryParse(_searchPrice.replaceAll(RegExp(r'[^0-9]'), '')); // Hapus karakter non-angka
                          if (filterPrice != null) {
                            matchPrice = budget >= filterPrice; // Mencari budget minimal sesuai input
                          }
                        }

                        return matchTitle && matchLocation && matchPrice;
                      }).toList();

                      if (filteredDocs.isEmpty) {
                         return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                          child: Center(child: Text("Pekerjaan tidak ditemukan", style: TextStyle(color: Colors.grey[600]))),
                        );
                      }
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: filteredDocs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            
                            int budget = 0;
                            if (data['budget'] != null) {
                              budget = int.tryParse(data['budget'].toString()) ?? 0;
                            }

                            return _buildJobItem(
                              fullData: data,
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
          GestureDetector(
            onTap: () => context.go('/klien/home'), 
            child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26)
          ),
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

  // 4. Update Filter Card dengan Input Fields
  Widget _buildFilterCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), 
          // Input Nama Projek
          _buildInputFilterField(
            icon: Icons.work_outline, 
            hint: "Cari Nama Pekerjaan...",
            onChanged: (val) {
              setState(() => _searchTitle = val);
            }
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Input Lokasi
              Expanded(
                child: _buildInputFilterField(
                  icon: Icons.location_on_outlined, 
                  hint: "Cari Lokasi",
                  onChanged: (val) {
                    setState(() => _searchLocation = val);
                  }
                )
              ),
              const SizedBox(width: 12),
              // Input Harga
              Expanded(
                child: _buildInputFilterField(
                  icon: Icons.attach_money_outlined, 
                  hint: "Min Harga",
                  inputType: TextInputType.number,
                  onChanged: (val) {
                    setState(() => _searchPrice = val);
                  }
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Helper Baru untuk Input Field dengan desain lama
  Widget _buildInputFilterField({
    required IconData icon, 
    required String hint, 
    required Function(String) onChanged,
    TextInputType inputType = TextInputType.text
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4), // Adjusted padding for TextField height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14), 
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)) // Sedikit transparan agar tidak terlalu tebal
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              keyboardType: inputType,
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                border: InputBorder.none, // Hilangkan garis bawah default TextField
              ),
            )
          ),
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
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
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
            onTap: () => context.push('/klien/job-detail', extra: fullData),
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