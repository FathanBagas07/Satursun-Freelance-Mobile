import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunGreen = Color(0xFF4CAF50); 
const Color _saturSunYellow = Color(0xFFFFC107); 

class TaskListScreenFreelancer extends StatefulWidget {
  const TaskListScreenFreelancer({super.key});

  @override
  State<TaskListScreenFreelancer> createState() => _TaskListScreenFreelancerState();
}

class _TaskListScreenFreelancerState extends State<TaskListScreenFreelancer> {
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

  int _parsePrice(dynamic price) {
    if (price == null) return 0;
    String priceStr = price.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(priceStr) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Tetap sama)
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
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3), // Index Task List
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
                // INPUT 1: Nama Proyek (Langsung ketik)
                // Menggantikan "Semua Pekerjaan"
                _buildSearchInput(
                  context,
                  icon: Icons.search,
                  hint: 'Cari Nama Proyek...',
                  isWide: true, // Agar ada border seperti desain awal
                  onChanged: (val) => setState(() => _searchName = val),
                ),
                
                const SizedBox(height: 15),
                
                Row(
                  children: [
                    // INPUT 2: Lokasi (Langsung ketik)
                    Expanded(
                      child: _buildSearchInput(
                        context,
                        icon: Icons.location_on,
                        hint: 'Cari Lokasi...',
                        isWide: false, // Menyesuaikan style baris kedua
                        onChanged: (val) => setState(() => _searchLocation = val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // INPUT 3: Harga (Langsung ketik)
                    Expanded(
                      child: _buildSearchInput(
                        context,
                        icon: Icons.account_balance_wallet_outlined,
                        hint: 'Min Harga...',
                        isWide: false,
                        isNumber: true,
                        onChanged: (val) => setState(() => _searchMinPrice = val),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          _buildTaskHeader(context, 'Tugas Aktif'),
          
          // StreamBuilder dengan Logika Search
          StreamBuilder<QuerySnapshot>(
            stream: jobService.getActiveTasksStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }
              
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(20), 
                  child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white))
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Tidak ada tugas aktif", style: TextStyle(color: Colors.white)),
                );
              }

              // === LOGIKA FILTER DI SINI ===
              var filteredDocs = snapshot.data!.docs.where((doc) {
                var data = doc.data() as Map<String, dynamic>;
                
                // Filter Nama
                String title = (data['title'] ?? '').toString().toLowerCase();
                if (_searchName.isNotEmpty && !title.contains(_searchName.toLowerCase())) {
                  return false;
                }

                // Filter Lokasi
                String location = (data['location'] ?? '').toString().toLowerCase();
                if (_searchLocation.isNotEmpty && !location.contains(_searchLocation.toLowerCase())) {
                  return false;
                }

                // Filter Harga
                if (_searchMinPrice.isNotEmpty) {
                  int budget = _parsePrice(data['budget']);
                  int minBudget = int.tryParse(_searchMinPrice) ?? 0;
                  if (budget < minBudget) {
                    return false;
                  }
                }
                return true;
              }).toList();

              if (filteredDocs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Tidak ada tugas yang cocok", style: TextStyle(color: Colors.black)),
                );
              }

              return Column(
                children: filteredDocs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final fullData = {...data, 'id': doc.id};
                  
                  return _buildTaskCard(
                    context, 
                    title: data['title'] ?? 'Tanpa Judul',
                    subTitle: 'Proyek Berjalan',
                    price: _formatRupiah(data['budget']),
                    progress: 0.0,
                    progressLabel: '0% Selesai',
                    isComplete: false,
                    taskData: fullData, 
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 30),
          
          _buildTaskHeader(context, 'Tugas Selesai'),
          
          StreamBuilder<QuerySnapshot>(
            stream: jobService.getCompletedTasksStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox.shrink();
              
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Belum ada tugas selesai", style: TextStyle(color: Colors.grey[600])),
                );
              }

              // Opsional: Filter juga untuk tugas selesai
              var filteredDocs = snapshot.data!.docs.where((doc) {
                var data = doc.data() as Map<String, dynamic>;
                String title = (data['title'] ?? '').toString().toLowerCase();
                if (_searchName.isNotEmpty && !title.contains(_searchName.toLowerCase())) return false;
                // Tambahkan filter lain jika perlu
                return true;
              }).toList();

              return Column(
                children: filteredDocs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return _buildTaskCard(
                    context, 
                    title: data['title'] ?? 'Tanpa Judul',
                    subTitle: 'Selesai',
                    price: _formatRupiah(data['budget']),
                    progress: 1.0,
                    progressLabel: '100% Selesai',
                    isComplete: true,
                    taskData: {},
                  );
                }).toList(),
              );
            },
          ),
          
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
            Padding(padding: const EdgeInsets.only(left: 20.0, top: 5), child: Text('Daftar Tugas', style: textTheme.displayMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface))),
          ],
        ),
      ),
    );
  }

  // --- Widget PENCARIAN BARU (Menggantikan _buildFilterButton) ---
  // Didesain agar terlihat SAMA PERSIS dengan tombol sebelumnya, tapi ini adalah TextField
  Widget _buildSearchInput(
    BuildContext context, {
    required IconData icon,
    required String hint,
    required Function(String) onChanged,
    required bool isWide,
    bool isNumber = false,
  }) {
    return Container(
      // Styling container sama persis dengan desain tombol sebelumnya
      padding: const EdgeInsets.symmetric(horizontal: 10), // Padding vertikal diatur di TextField contentPadding
      height: 48, // Tinggi disesuaikan agar pas dengan desain sebelumnya
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        // Logic border sama: Jika wide (atas) pakai border grey, jika tidak (bawah) tidak pakai (atau sesuaikan)
        // Agar terlihat konsisten sebagai input, saya sarankan semua pakai border tipis
        border: Border.all(color: Colors.grey[300]!), 
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          if (isWide) const SizedBox(width: 10) else const SizedBox(width: 5),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14, 
                fontWeight: FontWeight.w600
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.normal),
                border: InputBorder.none, // Hilangkan border bawaan TextField
                contentPadding: const EdgeInsets.only(bottom: 2), // Penyesuaian posisi teks vertikal
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskHeader(BuildContext context, String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5), child: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)));
  }

  Widget _buildTaskCard(BuildContext context, {
    required String title, 
    required String subTitle, 
    required String price, 
    required double progress, 
    required String progressLabel, 
    required bool isComplete,
    required Map<String, dynamic> taskData
  }) {
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
            if (!isComplete)
              GestureDetector(
                onTap: () { 
                  context.push('/freelancer/task-submission', extra: taskData); 
                }, 
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: detailColor, borderRadius: BorderRadius.circular(5)), child: Text('Detail', style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 12, fontWeight: FontWeight.bold)))
              )
            else
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: detailColor, borderRadius: BorderRadius.circular(5)), child: Text('Selesai', style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 12, fontWeight: FontWeight.bold)))
          ]),
        ],
      ),
    );
  }
}