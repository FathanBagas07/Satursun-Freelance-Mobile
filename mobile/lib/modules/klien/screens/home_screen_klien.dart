import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class HomeScreenKlien extends StatefulWidget {
  const HomeScreenKlien({super.key});

  @override
  State<HomeScreenKlien> createState() => _HomeScreenKlienState();
}

class _HomeScreenKlienState extends State<HomeScreenKlien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 0),
      body: Stack(
        children: [
          // GRADIENT BACKGROUND FULL SCREEN
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF009FFD),
                  Color(0xFFFF7A00),
                ],
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

                // PROYEK AKTIF SECTION
                _buildSectionTitle("Proyek Aktif"),
                const SizedBox(height: 12),
                _buildHorizontalList(children: [
                  _buildProjectCard(),
                  _buildProjectCard(),
                ]),

                const SizedBox(height: 32),

                // MEMBUTUHKAN TINDAKAN
                _buildSectionTitle("Membutuhkan Tindakan"),
                const SizedBox(height: 12),
                _buildHorizontalList(children: [
                  _buildActionCard(
                    title: "Lihat 5 Pelamar Baru Masuk",
                    subtitle: "Copywriting Promosi Produk",
                    icon: Icons.people,
                  ),
                  _buildActionCard(
                    title: "Lakukan Pembayaran",
                    subtitle: "Proyek Motion Graphic",
                    icon: Icons.payment,
                  ),
                ]),

                const SizedBox(height: 32),

                // STATISTIK SECTION
                _buildSectionTitle("Statistik Bulan Ini"),
                const SizedBox(height: 12),
                _buildHorizontalList(children: [
                  _buildStatCard(
                    icon: Icons.receipt_long,
                    label: "Pengeluaran Bln Ini",
                    value: "Rp4.500.000",
                  ),
                  _buildStatCard(
                    icon: Icons.check_circle,
                    label: "Proyek Selesai",
                    value: "18",
                  ),
                  _buildStatCard(
                    icon: Icons.person,
                    label: "Freelancer Aktif",
                    value: "12",
                  ),
                ]),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/logo.png", height: 100),
          const SizedBox(height: 1),
          const Text(
            "Halo, Saturnfren 👋",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // BUTTON CREATE JOB
  Widget _buildCreateJobButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/job-first-screen-klien'),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A00),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "+ Posting Pekerjaan Baru",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // HORIZONTAL WRAPPER
  Widget _buildHorizontalList({required List<Widget> children}) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 22),
          ...children.map((c) => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: c,
          )),
        ],
      ),
    );
  }

  // CARD: PROYEK AKTIF
  Widget _buildProjectCard() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: _whiteCardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Desain Poster Event Kampus",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Dikerjakan oleh: Aliafan",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: .3,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFFFF7A00),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          const Text("30% Selesai", style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  // CARD: ACTION REQUIRED
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: _whiteCardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFFF7A00), size: 30),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }

  // CARD: STATISTIK
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(18),
      decoration: _whiteCardStyle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: const Color(0xFF009FFD)),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ],
      ),
    );
  }

  // REUSABLE WHITE CARD STYLE
  BoxDecoration _whiteCardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
