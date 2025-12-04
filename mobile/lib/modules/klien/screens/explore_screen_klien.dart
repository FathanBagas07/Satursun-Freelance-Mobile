import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class ExploreScreenKlien extends StatefulWidget {
  const ExploreScreenKlien({super.key});

  @override
  State<ExploreScreenKlien> createState() => _ExploreScreenKlienState();
}

class _ExploreScreenKlienState extends State<ExploreScreenKlien> {
  bool smartFilter = true;

  final List<Map<String, dynamic>> freelancers = [
    {
      "name": "Alfatan",
      "skill": "Web development and Mobile development",
      "image": "assets/freelancer_icon.png",
      "progress": 0.55,
    },
    {
      "name": "Rezky",
      "skill": "Web development and AI Development",
      "image": "assets/freelancer_icon.png",
      "progress": 0.40,
    },
    {
      "name": "Arya",
      "skill": "Web development and AI Development",
      "image": "assets/freelancer_icon.png",
      "progress": 0.47,
    },
    {
      "name": "Nowel",
      "skill": "Web development and AI Development",
      "image": "assets/freelancer_icon.png",
      "progress": 0.32,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 1),
      body: Stack(
        children: [
          // ============================
          //   BLUE ORANGE GRADIENT TOP
          // ============================
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

                  // ============================
                  // HEADER + BACK BUTTON
                  // ============================
                  _buildHeader(),

                  const SizedBox(height: 16),

                  // ============================
                  // FILTER CARD
                  // ============================
                  _buildFilterCard(),

                  const SizedBox(height: 24),

                  // ============================
                  // REKOMENDASI PEKERJA
                  // ============================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Rekomendasi Pekerja Anda",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Column(
                    children: freelancers
                        .map((f) => _buildFreelancerItem(f))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================
  // HEADER
  // ============================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            // UPDATE: Navigasi ke Home Klien
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, '/home-klien', (route) => false),
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

  // ============================
  // FILTER CARD
  // ============================
  Widget _buildFilterCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FILTER TITLE + SWITCH
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter Pintar",
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

          // HARI KERJA FIELD
          _buildFilterField(
            icon: Icons.calendar_month_rounded,
            label: "Hari Kerja",
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _buildFilterField(
                  icon: Icons.location_on_outlined,
                  label: "Lokasi :\nUSU Medan",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterField(
                  icon: Icons.badge_rounded,
                  label: "Keahlian :\nWeb Development",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // FIELD COMPONENT
  Widget _buildFilterField({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ============================
  // FREELANCER ITEM
  // ============================
  Widget _buildFreelancerItem(Map<String, dynamic> f) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          // IMAGE
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(f["image"]),
          ),

          const SizedBox(width: 12),

          // NAME & SKILL
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "Skill: ${f["skill"]}",
                  style: const TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 6),

                // PROGRESS ORANGE
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

          // HIRE BUTTON
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