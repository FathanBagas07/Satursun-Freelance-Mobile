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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
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
              const SizedBox(height: 4),
              Text(
                "Posting Pekerjaan",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "(Langkah 1/2)",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
        Text(
          "Kategori Pekerjaan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
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
            hint: const Text("Pilih Kategori"),
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
        Text(
          "Dokumen Pendukung",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Logic untuk memilih file (Opsional untuk saat ini)
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
  // LANJUT BUTTON (MODIFIED)
  // ============================
  Widget _buildLanjutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          // 1. Validasi Input
          if (_judulController.text.isEmpty ||
              _lokasiController.text.isEmpty ||
              _selectedKategori == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Harap isi Judul, Lokasi, dan Kategori!")),
            );
            return;
          }

          // 2. Kirim Data ke Screen Kedua via Arguments
          Navigator.pushNamed(
            context,
            '/job-post-second',
            arguments: {
              'judul': _judulController.text,
              'lokasi': _lokasiController.text,
              'kategori': _selectedKategori,
            },
          );
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
              "Lanjut",
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