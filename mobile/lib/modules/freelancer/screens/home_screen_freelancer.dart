import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class HomeScreenFreelancer extends StatelessWidget {
  const HomeScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Mengambil style dasar dari tema
    final textTheme = Theme.of(context).textTheme;

    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: Container(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8AC1F5), Color(0xFFF8DC99)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 30,
              errorBuilder: (c, e, s) => Text(
                "SATURSUN",
                style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Halo, Saturfren!',
              // Menggunakan style global (displayMedium biasanya untuk judul besar) tapi di-override sesuai desain asli (24)
              style: textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Trending Weekend Jobs',
              style: textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTrendingJobsSection(context),
          const SizedBox(height: 20),
          _buildJobCard(
            context,
            title: 'Tutor Coding ASAP - Bayaran 2x',
            deadline: null,
          ),
          const SizedBox(height: 15),
          _buildJobCard(
            context,
            title: 'Desain Logo Event',
            deadline: 'Deadline jam 23.59 WIB',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTrendingJobsSection(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildTrendingJobCard(
            context,
            jobTitle: 'Desain Poster\nEvent Kampus',
            salary: 'Rp 100.000',
            note: '(per poster)',
            recommendation: 'Recommended for Teknik Industri',
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 15),
          _buildTrendingJobCard(
            context,
            jobTitle: 'Tutor Mate\nDasar',
            salary: 'Rp 75.00',
            note: '',
            recommendation: 'Recommended...',
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingJobCard(
    BuildContext context, {
    required String jobTitle,
    required String salary,
    required String note,
    required String recommendation,
    required Color color,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
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
          Text(jobTitle,
              style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(salary,
                  style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(width: 5),
              Text(note, style: textTheme.bodyMedium!.copyWith(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(recommendation,
                style: textTheme.bodyMedium!.copyWith(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, {required String title, String? deadline}) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                if (deadline != null) ...[
                  const SizedBox(height: 4),
                  Text(deadline,
                      style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.w500)),
                ],
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text('Unggah Portofolio Sekarang',
                      style: textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.assignment_outlined, size: 40, color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}