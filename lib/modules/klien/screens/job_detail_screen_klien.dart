import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JobDetailScreenKlien extends StatelessWidget {
  final Map<String, dynamic> jobData;

  const JobDetailScreenKlien({super.key, required this.jobData});

  @override
  Widget build(BuildContext context) {
    // Ambil data dengan nilai default jika null untuk menghindari error
    final title = jobData['title'] ?? 'Tanpa Judul';
    final description = jobData['description'] ?? 'Tidak ada deskripsi detail.';
    final budgetVal = jobData['budget'] ?? 0;
    final status = jobData['status'] ?? 'Open';
    final deadline = jobData['deadline'] ?? '-';
    final location = jobData['location'] ?? '-';
    final category = jobData['category'] ?? 'Umum';

    // Format tampilan budget
    String budgetStr = "Rp 0";
    if (budgetVal is int) {
      budgetStr = "Rp ${budgetVal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
    } else {
      budgetStr = budgetVal.toString();
    }

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient (Header)
          Container(
            height: 300,
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
            child: Column(
              children: [
                // 2. Custom Header Navigasi
                _buildHeader(context),

                // 3. Konten Putih Melengkung
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge Kategori & Status
                          Row(
                            children: [
                              _buildTag(category, Colors.blue.shade50, Colors.blue.shade700),
                              const SizedBox(width: 8),
                              _buildTag(
                                status.toUpperCase(),
                                status == 'active' || status == 'Open' 
                                    ? Colors.green.shade50 
                                    : Colors.orange.shade50,
                                status == 'active' || status == 'Open' 
                                    ? Colors.green.shade700 
                                    : Colors.orange.shade700,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Judul Proyek
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Lokasi
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 18, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(location, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Info Cards (Budget & Deadline)
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.monetization_on_outlined,
                                  label: "Budget Proyek",
                                  value: budgetStr,
                                  iconColor: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildInfoCard(
                                  context,
                                  icon: Icons.calendar_month_outlined,
                                  label: "Tenggat Waktu",
                                  value: deadline,
                                  iconColor: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Deskripsi
                          const Text(
                            "Deskripsi Pekerjaan",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[800],
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Tombol Aksi (Placeholder)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Fitur Edit akan segera hadir")),
                                );
                              },
                              icon: const Icon(Icons.edit, color: Colors.white),
                              label: const Text("Edit Proyek Ini", style: TextStyle(color: Colors.white, fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header dengan tombol kembali transparan
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            "Detail Proyek",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Tag Kategori/Status
  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Kartu Info Kecil
  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String label, required String value, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}