import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class ExploreScreenFreelancer extends StatefulWidget {
  const ExploreScreenFreelancer({super.key});

  @override
  State<ExploreScreenFreelancer> createState() => _ExploreScreenFreelancerState();
}

class _ExploreScreenFreelancerState extends State<ExploreScreenFreelancer> {
  // State untuk menyimpan nilai pencarian
  String _searchName = '';
  String _searchLocation = '';
  String _searchMinPrice = '';

  String _formatRupiah(dynamic price) {
    if (price == null) return "Rp 0";
    String priceStr = price.toString();
    String cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
    return "Rp ${cleanPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Helper untuk membersihkan format harga menjadi angka murni (int)
  int _parsePrice(dynamic price) {
    if (price == null) return 0;
    String priceStr = price.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(priceStr) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      body: Stack(
        children: [
          // ==============================
          // 1. BACKGROUND GRADIENT
          // ==============================
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

          // ==============================
          // 2. KONTEN
          // ==============================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(context),
                  const SizedBox(height: 16),
                  
                  // Bagian Pencarian (Dulu Filter Pintar)
                  _buildSearchSection(context),
                  
                  const SizedBox(height: 20),
                  
                  _buildSectionHeader(context, icon: Icons.star_border, title: 'Rekomendasi untuk Anda', isNew: true),
                  
                  // Stream Builder dengan Logika Filter
                  StreamBuilder<QuerySnapshot>(
                    stream: jobService.getAllJobsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Padding(padding: EdgeInsets.all(20), child: Center(child: Text("Belum ada lowongan tersedia")));
                      }

                      // LOGIKA SEARCH / FILTERING
                      var docs = snapshot.data!.docs.where((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        
                        // 1. Filter Nama Proyek
                        String title = (data['title'] ?? '').toString().toLowerCase();
                        if (_searchName.isNotEmpty && !title.contains(_searchName.toLowerCase())) {
                          return false;
                        }

                        // 2. Filter Lokasi
                        // Mengasumsikan field 'location' ada, jika tidak, kita cari di 'category' atau anggap cocok
                        String location = (data['location'] ?? '').toString().toLowerCase();
                        if (_searchLocation.isNotEmpty && !location.contains(_searchLocation.toLowerCase())) {
                          return false;
                        }

                        // 3. Filter Harga Minimal
                        if (_searchMinPrice.isNotEmpty) {
                          int budget = _parsePrice(data['budget']);
                          int minBudget = int.tryParse(_searchMinPrice) ?? 0;
                          if (budget < minBudget) {
                            return false;
                          }
                        }

                        return true;
                      }).toList();

                      if (docs.isEmpty) {
                         return Container(
                           padding: const EdgeInsets.all(20),
                           alignment: Alignment.center,
                           child: Column(
                             children: [
                               Icon(Icons.search_off, size: 50, color: Colors.grey[400]),
                               const SizedBox(height: 10),
                               Text("Proyek tidak ditemukan", style: TextStyle(color: Colors.grey[600])),
                             ],
                           ),
                         );
                      }

                      return Column(
                        children: docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final fullData = {...data, 'id': doc.id};

                          return _buildJobRecommendationCard(
                            context,
                            fullData: fullData, 
                            title: data['title'] ?? 'Tanpa Judul',
                            subtitle: data['category'] ?? 'Umum',
                            price: _formatRupiah(data['budget']),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  _buildSectionHeader(context, icon: Icons.bookmark_outline, title: 'Paket Lainnya', isNew: false),
                  _buildPackageCard(context, title: 'Tutor 3 Mata Kuliah', originalPrice: 'Rp 150.000', discountedPrice: 'Rp 120.000', discount: '20% off'),
                  _buildPackageCard(context, title: 'Tutor 2 Mata Kuliah', originalPrice: 'Rp 120.000', discountedPrice: 'Rp 93.500', discount: '22% off'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/freelancer/home'),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Text(
            "SaturSun Freelance",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // WIDGET FILTER / SEARCH (MODIFIKASI UTAMA)
  Widget _buildSearchSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cari Proyek', style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              Switch(value: true, onChanged: (bool value) {}, activeThumbColor: Theme.of(context).colorScheme.surface, activeTrackColor: Theme.of(context).colorScheme.secondary, inactiveThumbColor: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          
          // 1. Input Nama Proyek (Pengganti "Hanya Akhir Pekan")
          _buildSearchInput(
            context,
            icon: Icons.search,
            hint: 'Cari Nama Proyek...',
            onChanged: (val) => setState(() => _searchName = val),
          ),
          
          const SizedBox(height: 15),
          
          Row(
            children: [
              // 2. Input Lokasi (Pengganti Tombol Lokasi)
              Expanded(
                child: _buildSearchInput(
                  context,
                  icon: Icons.location_on,
                  hint: 'Cari Lokasi...',
                  onChanged: (val) => setState(() => _searchLocation = val),
                ),
              ),
              const SizedBox(width: 10),
              // 3. Input Harga Minimal (Pengganti Tombol Harga)
              Expanded(
                child: _buildSearchInput(
                  context,
                  icon: Icons.monetization_on_outlined,
                  hint: 'Min Harga...',
                  inputType: TextInputType.number,
                  onChanged: (val) => setState(() => _searchMinPrice = val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Input Reusable yang didesain mirip tombol sebelumnya
  Widget _buildSearchInput(
    BuildContext context, {
    required IconData icon,
    required String hint,
    required Function(String) onChanged,
    TextInputType inputType = TextInputType.text,
  }) {
    // Styling konsisten dengan tombol sebelumnya: Border Abu-abu tipis & Background Putih
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!), // Border konsisten
      ),
      child: TextField(
        onChanged: onChanged,
        keyboardType: inputType,
        style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.black, size: 20),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required IconData icon, required String title, required bool isNew}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 8),
          Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          if (isNew) ...[const SizedBox(width: 8), _buildNewTag(context)],
        ],
      ),
    );
  }

  Widget _buildNewTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(5)),
      child: Text('Baru', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildJobRecommendationCard(BuildContext context, {
    required Map<String, dynamic> fullData, 
    required String title, 
    required String subtitle, 
    required String price
  }) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        context.push('/freelancer/job-detail', extra: fullData);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15), 
              blurRadius: 10, 
              offset: const Offset(0, 4)
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Flexible(child: Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold))), const SizedBox(width: 8), _buildNewTag(context)]),
                  const SizedBox(height: 4),
                  Text(subtitle, style: textTheme.bodyMedium!.copyWith(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Text(price, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, {required String title, required String originalPrice, required String discountedPrice, required String discount}) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15), 
            blurRadius: 10, 
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(originalPrice, style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.grey[500], decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 5),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(5)), child: Text(discount, style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 4),
              Text(discountedPrice, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
            ],
          ),
        ],
      ),
    );
  }
}