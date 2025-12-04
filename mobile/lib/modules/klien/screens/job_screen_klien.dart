import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobScreenKlien extends StatefulWidget {
  const JobScreenKlien({super.key});

  @override
  State<JobScreenKlien> createState() => _JobScreenKlienState();
}

class _JobScreenKlienState extends State<JobScreenKlien> {
  // Data pekerjaan aktif
  final List<Map<String, dynamic>> _activeJobs = [
    {
      "title": "Desain Poster Acara",
      "description": "Cocok dengan keahlian desain grafis",
      "price": "Rp 75.000",
      "type": "active",
    },
    {
      "title": "Video Editing Promosi",
      "description": "Durasi 1-2 menit untuk konten sosial media",
      "price": "Rp 120.000",
      "type": "active",
    },
  ];

  // Data pekerjaan selesai
  final List<Map<String, dynamic>> _completedJobs = [
    {
      "title": "Asisten Riset Psikologi",
      "description": "Populer untuk mahasiswa Psikologi",
      "price": "Rp 60.000",
      "type": "completed",
    },
    {
      "title": "Input Data Excel",
      "description": "Data entry 1000 baris dengan ketelitian",
      "price": "Rp 45.000",
      "type": "completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          // ============================
          //   BLUE GRADIENT HEADER
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
                  // PEKERJAAN AKTIF SECTION
                  // ============================
                  _buildJobSection("Pekerjaan Aktif", _activeJobs),

                  const SizedBox(height: 24),

                  // ============================
                  // PEKERJAAN SELESAI SECTION
                  // ============================
                  _buildJobSection("Pekerjaan Selesai", _completedJobs),

                  const SizedBox(height: 24),

                  // ============================
                  // POSTING PEKERJAAN BARU BUTTON
                  // ============================
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Satursun Freelance",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Posting Pekerjaan",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 14,
                ),
              ),
            ],
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
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8), 

          // SEMUA PEKERJAAN FIELD
          _buildFilterField(
            icon: Icons.work_outline,
            label: "Semua Pekerjaan",
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _buildFilterField(
                  icon: Icons.location_on_outlined,
                  label: "Lokasi:\nUSU Medan",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterField(
                  icon: Icons.attach_money_outlined,
                  label: "Harga:\nRp 25k - 100k",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ============================
  // FILTER FIELD COMPONENT
  // ============================
  Widget _buildFilterField({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface, // REVISI: Warna hitam untuk teks
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================
  // JOB SECTION
  // ============================
  Widget _buildJobSection(String title, List<Map<String, dynamic>> jobs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface, // REVISI: Warna hitam untuk section title
            ),
          ),
          const SizedBox(height: 12),

          Column(
            children: jobs
                .map((job) => _buildJobItem(job))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ============================
  // JOB ITEM
  // ============================
  Widget _buildJobItem(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
        border: Border.all(
          color: job["type"] == "active" ? Theme.of(context).colorScheme.primary : Colors.green,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // JOB INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface, // Warna hitam
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  job["description"],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  job["price"],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // DETAIL BUTTON
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Detail",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  // ============================
  // POST JOB BUTTON
  // ============================
  Widget _buildPostJobButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          // ROUTE KE JOB POST SCREEN
          Navigator.pushNamed(context, '/job-post-first');
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "+ Posting Pekerjaan Baru",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}