import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_saturSunBlue, _saturSunLightBlue, _saturSunOrange],
                stops: [0.0, 0.35, 0.9],
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
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () { Navigator.pushReplacementNamed(context, '/home-freelancer'); }),
                Text('SaturSun Freelance', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Colors.white, backgroundImage: const AssetImage('assets/profile_pic.png'), child: const SizedBox.shrink()),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monica Raquella', style: textTheme.headlineMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('Freelance Teknik | 4.8 (32 reviews)', style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.white.withValues(alpha: 0.8), fontWeight: FontWeight.w500)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.work_outline, color: Colors.black, size: 24), const SizedBox(width: 8), Text('Portofolio', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold))]), GestureDetector(onTap: () {}, child: Text('Edit', style: textTheme.bodyLarge!.copyWith(fontSize: 16, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const SizedBox(height: 15),
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(15)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.cloud_upload_outlined, color: _saturSunBlue, size: 28), const SizedBox(width: 10), Text('Upload karya (max 5MB)', style: textTheme.bodyMedium!.copyWith(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w500))])),
        ],
      ),
    );
  }

  Widget _buildStudyModeCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.brightness_1, color: _saturSunOrange, size: 14), const SizedBox(width: 8), Text('Mode Kuliah', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold))]), Switch(value: true, onChanged: (bool value) {}, activeThumbColor: Colors.white, activeTrackColor: _saturSunOrange, inactiveThumbColor: Colors.grey)]),
          const SizedBox(height: 5),
          Text('Auto-reply: "Sedang ujian, akan dibalas secepatnya"', style: textTheme.bodyMedium!.copyWith(color: Colors.grey[700], fontSize: 14)),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildPlaceholderImage(context, 1), _buildPlaceholderImage(context, 2), _buildPlaceholderImage(context, 3)]),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context, int index) {
    return Container(width: 70, height: 70, color: _saturSunLightBlue.withValues(alpha: 0.5), child: Center(child: Text('Ilustrasi $index', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10, color: _saturSunBlue))));
  }

  Widget _buildTaskListSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.assignment_outlined, color: Colors.black, size: 24), const SizedBox(width: 8), Text('Daftar Tugas', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold))]), GestureDetector(onTap: () {}, child: Text('Lihat Semua', style: textTheme.bodyLarge!.copyWith(fontSize: 16, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const Divider(height: 30),
          _buildTaskItem(context, title: 'Desain Poster Event Kampus', subTitle: 'Bem Fasilkom-TI', progress: 0.3, progressLabel: '30% Selesai'),
          const Divider(height: 30),
          _buildTaskItem(context, title: 'Editing Video Dokumentasi', subTitle: 'Dikerjakan oleh : Arya', progress: 0.7, progressLabel: '70% Selesai'),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, {required String title, required String subTitle, required double progress, required String progressLabel}) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subTitle, style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Progress', style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.black54)), Text(progressLabel, style: textTheme.bodySmall!.copyWith(fontSize: 12, color: progress < 1.0 ? _saturSunOrange : _saturSunBlue, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 4),
        LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
      ],
    );
  }
}