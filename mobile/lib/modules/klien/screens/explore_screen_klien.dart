import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class ExploreScreenKlien extends StatefulWidget {
  const ExploreScreenKlien({super.key});

  @override
  State<ExploreScreenKlien> createState() => _ExploreScreenKlienState();
}

class _ExploreScreenKlienState extends State<ExploreScreenKlien> {
  bool smartFilter = true;

  // Variabel untuk menampung input pencarian
  String _keywordName = "";
  String _keywordLocation = "";
  String _keywordSkill = "";

  // Data Master (Ditambah field 'location')
  final List<Map<String, dynamic>> freelancers = [
    {
      "name": "Alfatan",
      "skill": "Web & Mobile Dev",
      "location": "Medan",
      "image": "assets/freelancer_icon.png",
      "progress": 0.90,
    },
    {
      "name": "Rezky",
      "skill": "AI Development",
      "location": "Jakarta",
      "image": "assets/freelancer_icon.png",
      "progress": 0.85,
    },
    {
      "name": "Arya",
      "skill": "Web Development",
      "location": "Medan",
      "image": "assets/freelancer_icon.png",
      "progress": 0.70,
    },
    {
      "name": "Nowel",
      "skill": "UI/UX Design",
      "location": "Bandung",
      "image": "assets/freelancer_icon.png",
      "progress": 0.60,
    },
  ];

  List<Map<String, dynamic>> _foundFreelancers = [];

  @override
  void initState() {
    _foundFreelancers = freelancers;
    super.initState();
  }

  // Fungsi Filter Gabungan (Nama + Lokasi + Skill)
  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    
    results = freelancers.where((user) {
      final nameMatch = user["name"].toLowerCase().contains(_keywordName.toLowerCase());
      final locationMatch = user["location"].toLowerCase().contains(_keywordLocation.toLowerCase());
      final skillMatch = user["skill"].toLowerCase().contains(_keywordSkill.toLowerCase());

      // Tampilkan jika semua kriteria cocok (Logic AND)
      return nameMatch && locationMatch && skillMatch;
    }).toList();

    setState(() {
      _foundFreelancers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 1),
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
                  
                  // Search Bar Utama (Nama)
                  _buildMainSearchBar(),
                  
                  const SizedBox(height: 16),
                  
                  // Filter Card (Lokasi & Skill Input)
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

                  // List Hasil
                  Column(
                    children: _foundFreelancers.isNotEmpty
                        ? _foundFreelancers.map((f) => _buildFreelancerItem(f)).toList()
                        : [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(child: Text("Freelancer tidak ditemukan")),
                            )
                          ],
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
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home-klien', (route) => false),
            child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26),
          ),
          const SizedBox(width: 12),
          Text(
            "Satursun Freelance",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 1. Search Bar Utama (Nama)
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
          _keywordName = value;
          _runFilter();
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

  // 2. Filter Card (Input Lokasi & Skill)
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
          
          // Row Input Lokasi & Skill
          Row(
            children: [
              // Input Lokasi
              Expanded(
                child: _buildInputBox(
                  icon: Icons.location_on_outlined,
                  hint: "Cari Lokasi...",
                  onChanged: (val) {
                    _keywordLocation = val;
                    _runFilter();
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Input Skill
              Expanded(
                child: _buildInputBox(
                  icon: Icons.badge_rounded,
                  hint: "Cari Skill...",
                  onChanged: (val) {
                    _keywordSkill = val;
                    _runFilter();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget Input Kecil di dalam Filter Card
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

  Widget _buildFreelancerItem(Map<String, dynamic> f) {
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
            backgroundImage: AssetImage(f["image"]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f["name"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  "${f["skill"]} • ${f["location"]}", // Tampilkan Lokasi juga
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: f["progress"],
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