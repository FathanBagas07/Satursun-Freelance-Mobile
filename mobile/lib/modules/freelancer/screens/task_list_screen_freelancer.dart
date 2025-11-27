import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunGreen = Color(0xFF4CAF50); 
const Color _saturSunYellow = Color(0xFFFFC107); 

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

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
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.onPrimary, Theme.of(context).colorScheme.secondary],
                stops: [0.0, 0.3, 0.9],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _buildFilterButton(context, icon: Icons.calendar_today, label: 'Semua Pekerjaan', onTap: () {}),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: _buildFilterButton(context, icon: Icons.location_on, label: 'Lokasi: USU Medan', onTap: () {})),
                    const SizedBox(width: 10),
                    Expanded(child: _buildFilterButton(context, icon: Icons.account_balance_wallet_outlined, label: 'Harga: Rp 25k - 100k', onTap: () {})),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildTaskHeader(context, 'Tugas Aktif'),
          _buildTaskCard(context, title: 'Desain Poster Event Kampus', subTitle: 'Bem Fasilkom-TI', price: 'Rp 75.000', progress: 0.3, progressLabel: '30% Selesai', isComplete: false),
          const SizedBox(height: 30),
          _buildTaskHeader(context, 'Tugas Selesai'),
          _buildTaskCard(context, title: 'Editing Video Dokumentasi', subTitle: 'IMILKOM', price: 'Rp 75.000', progress: 1.0, progressLabel: '100% Selesai', isComplete: true),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface), onPressed: () { Navigator.pushReplacementNamed(context, '/home-freelancer'); }),
                Text('SaturSun Freelance', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.surface)),
              ],
            ),
            Padding(padding: const EdgeInsets.only(left: 20.0, top: 5), child: Text('Daftar Tugas', style: textTheme.displayMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isWide = !label.contains(':');
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: isWide ? Border.all(color: Colors.grey[300]!) : null),
          child: Row(mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center, children: [Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20), if (isWide) const SizedBox(width: 10), Flexible(child: Text(label, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis))]),
        ),
      ),
    );
  }

  Widget _buildTaskHeader(BuildContext context, String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5), child: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)));
  }

  Widget _buildTaskCard(BuildContext context, {required String title, required String subTitle, required String price, required double progress, required String progressLabel, required bool isComplete}) {
    final Color detailColor = isComplete ? _saturSunGreen : Theme.of(context).colorScheme.error;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(subTitle, style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Colors.grey[600]))])),
              const SizedBox(width: 10),
              Text(price, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: isComplete ? _saturSunGreen : Theme.of(context).colorScheme.secondary)),
            ],
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunYellow), minHeight: 5)), 
            const SizedBox(width: 10), 
            Text(progressLabel, style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)), 
            const SizedBox(width: 15), 
            GestureDetector(
              onTap: () { 
                Navigator.pushNamed(context, '/task-submission'); 
              }, 
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                decoration: BoxDecoration(color: detailColor, borderRadius: BorderRadius.circular(5)), 
                child: Text('Detail', style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 12, fontWeight: FontWeight.bold))
              )
            )
          ]),
        ],
      ),
    );
  }
}