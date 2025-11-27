import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

// Definisi warna
const Color _saturSunGrey = Color(0xFFBDBDBD);

class TaskSubmissionScreen extends StatelessWidget {
  const TaskSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.secondary,
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Scrollable Content
          _buildBody(context),
        ],
      ),
      // Menggunakan CustomBottomNavBar (Index 3: Tugas)
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      
      // Tombol "Kumpul" melayang di atas BottomNavBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            // --- LOGIKA NAVIGASI ---
            // Kembali ke Daftar Tugas (Task List)
            Navigator.pop(context);
            
            // Opsional: Tampilkan pesan sukses
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Tugas berhasil dikumpulkan!"),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          child: Text(
            'Kumpul',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      // Padding bawah ekstra agar konten tidak tertutup tombol & nav bar
      padding: const EdgeInsets.only(bottom: 160),
      child: Column(
        children: [
          _buildAppBar(context),
          const SizedBox(height: 10),

          // Header Judul & Status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengumpulan Tugas',
                  style: textTheme.headlineMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Progres',
                    style: textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // --- KARTU UPLOAD (RATA TENGAH) ---
          Center(child: _buildUploadCard(context)),
          
          const SizedBox(height: 20),

          // --- CATATAN TAMBAHAN ---
          _buildNotesCard(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'SaturSun Freelance',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Lebar kartu disesuaikan dengan layar minus margin kanan-kiri
    double cardWidth = MediaQuery.of(context).size.width - 40;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu (Judul Tugas & Tombol Edit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menggunakan Expanded agar teks tidak menabrak tombol Edit
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.assignment_outlined, color: Theme.of(context).colorScheme.onSurface, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Desain Poster Acara',
                        overflow: TextOverflow.ellipsis, // Mencegah overflow teks
                        maxLines: 1,
                        style: textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Edit',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // --- AREA UPLOAD RATA TENGAH ---
          Container(
            width: double.infinity, // Memenuhi lebar parent
            height: 200, // Tinggi fix agar kotak terlihat proporsional (kotak)
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Konten vertikal di tengah
              crossAxisAlignment: CrossAxisAlignment.center, // Konten horizontal di tengah
              children: [
                Icon(Icons.cloud_upload_outlined, color: Theme.of(context).colorScheme.primary, size: 50),
                const SizedBox(height: 15),
                Text(
                  'Upload karya (max 20MB)',
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Logika pilih file
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    'Pilih File',
                    style: textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // List File yang sudah diupload
          const Divider(),
          const SizedBox(height: 10),
          _buildUploadedFileItem(context, 'poster_final_v2.jpg', '15MB'),
          _buildUploadedFileItem(context, 'konsep_warna.pdf', '350KB'),
        ],
      ),
    );
  }

  Widget _buildUploadedFileItem(BuildContext context, String fileName, String fileSize) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              Text(
                fileSize,
                style: textTheme.bodySmall!.copyWith(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: (){},
                child: const Icon(Icons.delete_outline, color: _saturSunGrey, size: 20)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Catatan Tambahan (opsional)',
            style: textTheme.bodyLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'contoh : Halo, berikut hasil desainnya.',
              hintStyle: textTheme.bodyMedium!.copyWith(color: Colors.grey[400], fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(15),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            style: textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}