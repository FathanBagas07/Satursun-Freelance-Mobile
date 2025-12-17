import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/modules/auth/services/auth_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class ProfileScreenFreelancer extends StatefulWidget {
  const ProfileScreenFreelancer({super.key});

  @override
  State<ProfileScreenFreelancer> createState() => _ProfileScreenFreelancerState();
}

class _ProfileScreenFreelancerState extends State<ProfileScreenFreelancer> {
  String _fullName = "Memuat...";
  String _role = "Freelancer";
  String? _photoUrl;
  // ignore: unused_field
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          if (mounted) {
            setState(() {
              String first = data['firstName'] ?? '';
              String last = data['lastName'] ?? '';
              _fullName = "$first $last".trim();
              if (_fullName.isEmpty) _fullName = "User Tanpa Nama";
              
              _role = data['role'] ?? 'Freelancer';
              _photoUrl = data['photoUrl'];
              _isLoading = false;
            });
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _fullName = "Error memuat data";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.secondary
                ],
                stops: const [0.0, 0.35, 0.9],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 10),
          _buildPortfolioCard(context),
          const SizedBox(height: 20),
          _buildStudyModeCard(context),
          const SizedBox(height: 20),
          
          // Bagian Daftar Tugas yang sudah dinamis
          _buildTaskListSection(context),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      context.go('/freelancer/home');
                    }),
                Text('SaturSun Freelance',
                    style: textTheme.titleLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  onSelected: (String result) async {
                    if (result == 'logout') {
                      await AuthService().signOut();
                      if (context.mounted) {
                        context.go('/sign-in');
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text('Logout',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      height: 10,
                      enabled: false,
                      child: SizedBox.shrink(),
                    ),
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text('Settings',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      backgroundImage: _photoUrl != null 
                          ? NetworkImage(_photoUrl!) 
                          : const AssetImage('assets/profile_pic.png') as ImageProvider,
                      child: const SizedBox.shrink()),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_fullName,
                          style: textTheme.headlineMedium!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surface)),
                      const SizedBox(height: 4),
                      Text('$_role | 4.8 (32 reviews)',
                          style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioCard(BuildContext context) {
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
                offset: const Offset(0, 5))
          ]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.work_outline,
                  color: Theme.of(context).colorScheme.onSurface, size: 24),
              const SizedBox(width: 8),
              Text('Portofolio',
                  style: textTheme.titleLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold))
            ]),
            GestureDetector(
                onTap: () {},
                child: Text('Edit',
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)))
          ]),
          const SizedBox(height: 15),
          Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.cloud_upload_outlined,
                    color: Theme.of(context).colorScheme.primary, size: 28),
                const SizedBox(width: 10),
                Text('Upload karya (max 5MB)',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ])),
        ],
      ),
    );
  }

  Widget _buildStudyModeCard(BuildContext context) {
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
                offset: const Offset(0, 5))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.brightness_1,
                  color: Theme.of(context).colorScheme.secondary, size: 14),
              const SizedBox(width: 8),
              Text('Mode Kuliah',
                  style: textTheme.titleLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold))
            ]),
            Switch(
                value: true,
                onChanged: (bool value) {},
                activeThumbColor: Theme.of(context).colorScheme.surface,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                inactiveThumbColor: Colors.grey)
          ]),
          const SizedBox(height: 5),
          Text('Auto-reply: "Sedang ujian, akan dibalas secepatnya"',
              style: textTheme.bodyMedium!
                  .copyWith(color: Colors.grey[700], fontSize: 14)),
        ],
      ),
    );
  }

  // --- BAGIAN DAFTAR TUGAS DINAMIS ---
  Widget _buildTaskListSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

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
                offset: const Offset(0, 5))
          ]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.assignment_outlined,
                  color: Theme.of(context).colorScheme.onSurface, size: 24),
              const SizedBox(width: 8),
              Text('Daftar Tugas',
                  style: textTheme.titleLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold))
            ]),
            GestureDetector(
                onTap: () {
                  context.go('/freelancer/tasks');
                },
                child: Text('Lihat Semua',
                    style: textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)))
          ]),
          const Divider(height: 30),

          // --- LOGIKA STREAM BUILDER UNTUK MENGAMBIL TUGAS AKTIF ---
          if (user != null)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where('freelancerId', isEqualTo: user.uid)
                  .where('status', isEqualTo: 'Active') // Hanya tugas AKTIF
                  .limit(3) // Batasi tampilan agar tidak terlalu panjang di profil
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text("Belum ada tugas aktif", 
                      style: textTheme.bodyMedium!.copyWith(color: Colors.grey[500])),
                  );
                }

                // Render List Tugas Aktif
                return Column(
                  children: snapshot.data!.docs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final doc = entry.value;
                    final data = doc.data() as Map<String, dynamic>;
                    
                    // Ambil progress jika ada, default ke 0
                    double progress = 0.0;
                    if (data['progress'] != null) {
                      progress = (data['progress'] is int) 
                          ? (data['progress'] as int).toDouble() 
                          : (data['progress'] as double);
                    }
                    String progressLabel = "${(progress * 100).toInt()}% Selesai";

                    return Column(
                      children: [
                        _buildTaskItem(context,
                            title: data['title'] ?? 'Tanpa Judul',
                            subTitle: data['category'] ?? 'Proyek Berjalan',
                            progress: progress,
                            progressLabel: progressLabel),
                        
                        // Tambahkan divider kecuali di item terakhir
                        if (index < snapshot.data!.docs.length - 1) 
                          const Divider(height: 30),
                      ],
                    );
                  }).toList(),
                );
              },
            )
          else
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Silakan login untuk melihat tugas"),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context,
      {required String title,
      required String subTitle,
      required double progress,
      required String progressLabel}) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: textTheme.bodyLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subTitle,
            style: textTheme.bodyMedium!
                .copyWith(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Progress',
              style: textTheme.bodySmall!
                  .copyWith(fontSize: 12, color: Theme.of(context).colorScheme.onSurface)),
          Text(progressLabel,
              style: textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  color: progress < 1.0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600))
        ]),
        const SizedBox(height: 4),
        LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.secondary),
            minHeight: 5),
      ],
    );
  }
}