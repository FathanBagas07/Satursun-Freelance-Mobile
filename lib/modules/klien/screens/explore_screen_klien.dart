import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class ExploreScreenKlien extends StatefulWidget {
  const ExploreScreenKlien({super.key});

  @override
  State<ExploreScreenKlien> createState() => _ExploreScreenKlienState();
}

class _ExploreScreenKlienState extends State<ExploreScreenKlien> {
  bool smartFilter = true;

  // Variabel Pencarian
  String _keywordName = "";
  // Variabel Lokasi & Skill (Dummy/Visual Saja)
  String _keywordLocation = "";
  String _keywordSkill = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 1),
      body: Stack(
        children: [
          // ==============================
          // BACKGROUND GRADIENT
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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 16),
                  
                  // Search Bar Utama
                  _buildMainSearchBar(),
                  
                  const SizedBox(height: 16),
                  
                  // Filter Card (Visual Saja)
                  _buildFilterInputCard(),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Rekomendasi Pekerja Anda",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==============================
                  // STREAM BUILDER (PERBAIKAN)
                  // ==============================
                  StreamBuilder<QuerySnapshot>(
                    // PERBAIKAN: Ambil semua user dulu, filter role dilakukan di bawah
                    // agar tidak masalah huruf besar/kecil (Freelancer vs freelancer)
                    stream: FirebaseFirestore.instance.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      // 1. Loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      // 2. Error
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }

                      // 3. Logic Filter Data
                      var docs = snapshot.data?.docs ?? [];
                      
                      var filteredList = docs.where((doc) {
                        var data = doc.data() as Map<String, dynamic>;

                        // A. FILTER ROLE (Case Insensitive)
                        // Pastikan role ada, ubah ke string, lalu kecilkan hurufnya
                        String role = (data['role'] ?? '').toString().toLowerCase();
                        // Hanya ambil jika role mengandung kata 'freelancer'
                        if (!role.contains('freelancer')) {
                          return false; 
                        }

                        // B. FILTER NAMA (Pencarian)
                        String firstName = (data['firstName'] ?? '').toString();
                        String lastName = (data['lastName'] ?? '').toString();
                        String fullName = "$firstName $lastName".trim();
                        if (fullName.isEmpty) fullName = (data['name'] ?? '').toString();

                        // Cek kecocokan nama dengan input pencarian
                        bool nameMatch = fullName.toLowerCase().contains(_keywordName.toLowerCase());

                        return nameMatch;
                      }).toList();

                      // 4. Jika Kosong
                      if (filteredList.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Icon(Icons.person_search_outlined, size: 60, color: Colors.grey[300]),
                              const SizedBox(height: 10),
                              Text(
                                "Freelancer tidak ditemukan",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "(Pastikan ada user dengan role 'freelancer' di Database)",
                                style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      // 5. Tampilkan Hasil
                      return Column(
                        children: filteredList.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return _buildFreelancerItem(data);
                        }).toList(),
                      );
                    },
                  ),
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
            child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26),
          ),
          const SizedBox(width: 12),
          const Text(
            "Satursun Freelance",
            style: TextStyle(
              color: Colors.black, // Hitam
              fontSize: 22,
              fontWeight: FontWeight.bold, // Bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _keywordName = value;
          });
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Cari Nama Freelancer...',
          hintStyle: TextStyle(color: Colors.grey),
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildFilterInputCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter Detail",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Switch(
                value: smartFilter,
                activeThumbColor: Theme.of(context).colorScheme.secondary,
                onChanged: (v) => setState(() => smartFilter = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInputBox(
                  icon: Icons.location_on_outlined,
                  hint: "Cari Lokasi...",
                  onChanged: (val) {
                    setState(() => _keywordLocation = val);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputBox(
                  icon: Icons.badge_rounded,
                  hint: "Cari Skill...",
                  onChanged: (val) {
                    setState(() => _keywordSkill = val);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox({
    required IconData icon, 
    required String hint, 
    required Function(String) onChanged
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreelancerItem(Map<String, dynamic> data) {
    // 1. Ambil Nama (Gabungan firstName + lastName)
    String firstName = (data['firstName'] ?? '').toString();
    String lastName = (data['lastName'] ?? '').toString();
    String fullName = "$firstName $lastName".trim();
    if (fullName.isEmpty) fullName = (data['name'] ?? 'Tanpa Nama').toString();

    // 2. Skill & Lokasi (Dummy jika kosong agar tampilan tidak rusak)
    String skill = (data['skill'] != null && data['skill'].toString().isNotEmpty) 
        ? data['skill'] 
        : 'Freelancer'; 
    
    String location = (data['location'] != null && data['location'].toString().isNotEmpty)
        ? data['location']
        : 'Indonesia';

    // 3. Rating (Dummy)
    double progress = 0.8;
    if (data['rating'] != null) {
      progress = (double.tryParse(data['rating'].toString()) ?? 0.0) / 5.0;
    }

    // 4. Foto Profil
    ImageProvider imageProvider;
    String? photoUrl = data['photo_url'];
    if (photoUrl != null && photoUrl.isNotEmpty && photoUrl.startsWith('http')) {
      imageProvider = NetworkImage(photoUrl);
    } else {
      imageProvider = const AssetImage("assets/freelancer_icon.png");
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            backgroundImage: imageProvider,
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  "$skill • $location",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.grey[200],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Hire",
              style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}