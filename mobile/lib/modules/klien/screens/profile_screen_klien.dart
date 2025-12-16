import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/auth_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

class ProfileKlienScreen extends StatefulWidget {
  const ProfileKlienScreen({super.key});

  @override
  State<ProfileKlienScreen> createState() => _ProfileKlienScreenState();
}

class _ProfileKlienScreenState extends State<ProfileKlienScreen> {
  String _fullName = "Memuat...";
  String _role = "Klien";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fungsi mengambil data user dari Firestore
  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          if (mounted) {
            setState(() {
              // Gabungkan Nama Depan dan Belakang
              String first = data['firstName'] ?? '';
              String last = data['lastName'] ?? '';
              _fullName = "$first $last".trim();
              if (_fullName.isEmpty) _fullName = "User Tanpa Nama";
              
              _role = data['role'] ?? 'Klien';
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

  // Fungsi Logout
  Future<void> _handleLogout() async {
    await authService.signOut();
    if (mounted) {
      context.go('/sign-in');
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
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 4),
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
          _buildHiddenModeCard(context),
          const SizedBox(height: 20),
          _buildActivitySection(context),
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
                    icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface),
                    onPressed: () {
                      context.go('/klien/home');
                    }),
                Text(
                  'Satursun Freelance',
                  style: textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                // MENU LOGOUT & SETTINGS
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'logout') {
                      _handleLogout();
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
                        child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      height: 10,
                      enabled: false,
                      child: SizedBox.shrink(), // Spacer
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
                        child: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    backgroundImage: const AssetImage('assets/profile_pic.png'),
                    onBackgroundImageError: (exception, stackTrace) {
                      // Fallback jika gambar tidak ada
                    },
                    child: _isLoading ? null : const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAMA USER DARI FIREBASE
                      _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(
                            _fullName,
                            style: textTheme.headlineMedium!.copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
                          ),
                      const SizedBox(height: 4),
                      Text(
                        '$_role  |  4.8 (32 reviews)',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
          BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.folder_special_outlined, color: Theme.of(context).colorScheme.onSurface, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Portofolio klien',
                    style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Edit',
                  style: textTheme.bodyLarge!.copyWith(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
                const SizedBox(width: 20),
                Text(
                  'Upload Portofolio rekrutmen\n (max 5MB)',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenModeCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility_off_outlined, color: Theme.of(context).colorScheme.secondary, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Mode Tersembunyi',
                    style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Switch(
                value: true,
                onChanged: (bool value) {},
                activeThumbColor: Theme.of(context).colorScheme.surface,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                inactiveThumbColor: Colors.grey,
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Auto Reply: "Saat ini saya sedang membuka rekrutmen secara privat. Hanya kandidat terpilih yang akan dihubungi."',
            style: textTheme.bodyMedium!.copyWith(color: Colors.grey[700], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.onSurface, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Aktivitas Mei 2025',
                    style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('5 Unggah Pekerjaan', style: textTheme.bodyMedium!.copyWith(fontSize: 15, color: Theme.of(context).colorScheme.primary)),
              Text('3 Orang di Rekrut', style: textTheme.bodyMedium!.copyWith(fontSize: 15, color: Theme.of(context).colorScheme.onSurface)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
            minHeight: 5,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Blokir notifikasi Senin–Jumat',
                  style: textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 15)),
              Switch(
                value: true,
                onChanged: (bool value) {},
                activeThumbColor: Theme.of(context).colorScheme.surface,
                activeTrackColor: Theme.of(context).colorScheme.secondary,
                inactiveThumbColor: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
  }
}