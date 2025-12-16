import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class JobPostFirstScreenKlien extends StatefulWidget {
  const JobPostFirstScreenKlien({super.key});

  @override
  State<JobPostFirstScreenKlien> createState() => _JobPostFirstScreenKlienState();
}

class _JobPostFirstScreenKlienState extends State<JobPostFirstScreenKlien> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  String? _selectedKategori;

  final List<String> _kategoriList = [
    'Desain Grafis', 'Web Development', 'Mobile Development', 
    'Video Editing', 'Penulisan Konten', 'Data Entry', 'Marketing', 'Lainnya'
  ];

  @override
  void dispose() {
    _judulController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 3),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildFormCard(),
                  const SizedBox(height: 32),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(), // Navigasi Back
            child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface, size: 26),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Satursun Freelance", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 22, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text("Posting Pekerjaan", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text("(Langkah 1/2)", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          _buildFormField(label: "Judul Pekerjaan", hintText: "Desain Poster Acara", controller: _judulController, icon: Icons.title),
          const SizedBox(height: 20),
          _buildFormField(label: "Lokasi Pekerjaan", hintText: "Universitas Sumatera Utara", controller: _lokasiController, icon: Icons.location_on),
          const SizedBox(height: 20),
          _buildKategoriField(),
          const SizedBox(height: 20),
          _buildDokumenField(),
        ],
      ),
    );
  }

  Widget _buildFormField({required String label, required String hintText, required TextEditingController controller, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
          child: TextField(controller: controller, decoration: InputDecoration(hintText: hintText, hintStyle: TextStyle(color: Colors.grey[500]), border: InputBorder.none, icon: Icon(icon, color: Colors.grey[600]))),
        ),
      ],
    );
  }

  Widget _buildKategoriField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kategori Pekerjaan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedKategori,
            decoration: const InputDecoration(border: InputBorder.none, icon: Icon(Icons.category, color: Colors.grey)),
            items: _kategoriList.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
            onChanged: (newValue) => setState(() => _selectedKategori = newValue),
            hint: const Text("Pilih Kategori"),
          ),
        ),
      ],
    );
  }

  Widget _buildDokumenField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dokumen Pendukung", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!)),
          child: Row(children: [Icon(Icons.attach_file, color: Colors.grey[600]), const SizedBox(width: 12), const Text("Lampirkan File (Opsional)", style: TextStyle(color: Colors.grey))]),
        ),
      ],
    );
  }

  // LOGIKA TOMBOL LANJUT
  Widget _buildLanjutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          if (_judulController.text.isEmpty || _lokasiController.text.isEmpty || _selectedKategori == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lengkapi semua data")));
            return;
          }
          final data = {
            'title': _judulController.text,
            'location': _lokasiController.text,
            'category': _selectedKategori,
          };
          context.push('/klien/job-post-second', extra: data);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text("Lanjut", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 17, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}