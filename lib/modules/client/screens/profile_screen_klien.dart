import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/widgets/custom_bottom_nav_bar_klien.dart';
import 'package:satursun_app/modules/auth/services/auth_service.dart';
import 'package:satursun_app/modules/client/controllers/profile_controller.dart';
import 'package:satursun_app/modules/client/services/profile_service.dart';

class ProfileKlienScreen extends StatefulWidget {
  const ProfileKlienScreen({super.key});

  @override
  State<ProfileKlienScreen> createState() => _ProfileKlienScreenState();
}

class _ProfileKlienScreenState extends State<ProfileKlienScreen> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = ProfileController(ProfileService());
    controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(context),
          AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return _buildBody(context);
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBarClient(currentIndex: 4),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.secondary,
          ],
          stops: const [0.0, 0.35, 0.9],
        ),
      ),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () => context.go('/klien/home'),
                ),
                Text(
                  'Satursun Freelance',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'logout') {
                      final router = GoRouter.of(
                        context,
                      ); // simpan sebelum await

                      await authService.signOut();

                      if (!mounted) return;
                      router.go('/sign-in');
                    }
                  },

                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text(
                        'Logout',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: controller.photoUrl != null
                      ? NetworkImage(controller.photoUrl!)
                      : const AssetImage('assets/profile_pic.png')
                            as ImageProvider,
                ),
                const SizedBox(width: 15),
                controller.isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.fullName,
                            style: textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.role,
                            style: textTheme.bodyMedium!.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioCard(BuildContext context) {
    return _simpleCard(
      context,
      icon: Icons.folder_special_outlined,
      title: 'Portofolio klien',
      content: 'Upload Portofolio rekrutmen (max 5MB)',
    );
  }

  Widget _buildHiddenModeCard(BuildContext context) {
    return _simpleCard(
      context,
      icon: Icons.visibility_off_outlined,
      title: 'Mode Tersembunyi',
      content: 'Auto Reply: "Saat ini saya membuka rekrutmen secara privat."',
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    return _simpleCard(
      context,
      icon: Icons.bar_chart,
      title: 'Aktivitas Mei 2025',
      content: '5 Unggah Pekerjaan • 3 Orang Direkrut',
    );
  }

  Widget _simpleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(content),
        ],
      ),
    );
  }
}
