import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobPostFirstScreenKlien extends StatefulWidget {
  const JobPostFirstScreenKlien({super.key});

  @override
  State<JobPostFirstScreenKlien> createState() => _JobPostFirstScreenKlienState();
}

class _JobPostFirstScreenKlienState extends State<JobPostFirstScreenKlien> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();

  String? _selectedKategori;

  final List<String> _kategoriList = [
    'Desain Grafis',
    'Web Development',
    'Mobile Development',
    'Video Editing',
    'Penulisan Konten',
    'Data Entry',
    'Marketing',
    'Lainnya'
  ];

  @override
  void dispose() {
    _judulController.dispose();
    _lokasiController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          // ============================
          //   GRADIENT BACKGROUND FULL SCREEN
          // ============================
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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ============================
                  // HEADER + BACK BUTTON
                  // ============================
                  _buildHeader(),

                  const SizedBox(height: 24),

                  // ============================
                  // FORM CARD
                  // ============================
                  _buildFormCard(),

                  const SizedBox(height: 32),

                  // ============================
                  // LANJUT BUTTON
                  // ============================
                  _buildLanjutButton(),

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
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // REVISI: Satursun Freelance warna putih rata kiri
              Text(
                "Satursun Freelance",
                style: TextStyle(
                  color: Colors.white, // Warna putih
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              // REVISI: Posting Pekerjaan warna hitam
              Text(
                "Posting Pekerjaan",
                style: TextStyle(
                  color: Colors.black, // Warna hitam
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "(Langkah 1/2)",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================
  // FORM CARD
  // ============================
  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL PEKERJAAN
          _buildFormField(
            label: "Judul Pekerjaan",
            hintText: "Desain Poster Acara",
            controller: _judulController,
            icon: Icons.title,
          ),

          const SizedBox(height: 20),

          // LOKASI PEKERJAAN
          _buildFormField(
            label: "Lokasi Pekerjaan",
            hintText: "Universitas Sumatera Utara",
            controller: _lokasiController,
            icon: Icons.location_on,
          ),

          const SizedBox(height: 20),

          // KATEGORI PEKERJAAN (DROPDOWN)
          _buildKategoriField(),

          const SizedBox(height: 20),

          // DOKUMEN PENDUKUNG
          _buildDokumenField(),
        ],
      ),
    );
  }

  // ============================
  // FORM FIELD COMPONENT
  // ============================
  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: InputBorder.none,
              icon: Icon(icon, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }

  // ============================
  // KATEGORI DROPDOWN FIELD
  // ============================
  Widget _buildKategoriField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kategori Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedKategori,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.category, color: Colors.grey),
            ),
            items: _kategoriList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedKategori = newValue;
              });
            },
            hint: const Text("Desain Grafis"),
          ),
        ),
      ],
    );
  }

  // ============================
  // DOKUMEN PENDUKUNG FIELD
  // ============================
  Widget _buildDokumenField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dokumen Pendukung",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Logic untuk memilih file
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_file, color: Colors.grey[600]),
                const SizedBox(width: 12),
                const Text(
                  "Lampirkan File (Opsional)",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================
  // LANJUT BUTTON (MIRIP POSTING PEKERJAAN BARU)
  // ============================
  Widget _buildLanjutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          // ROUTE KE JOB POST SECOND SCREEN
          Navigator.pushNamed(context, '/job-post-second');
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A00),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Text(
              "Lanjut",
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
}