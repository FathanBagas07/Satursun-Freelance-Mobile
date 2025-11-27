import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

class ExploreScreenFreelancer extends StatelessWidget {
  const ExploreScreenFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home-freelancer');
        },
      ),
      // Menggunakan style dari tema
      title: Text('SaturSun Freelance',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 18)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSection(context),
          const SizedBox(height: 20),
          _buildSectionHeader(context, icon: Icons.star_border, title: 'Rekomendasi untuk Anda', isNew: true),
          _buildJobRecommendationCard(context, title: 'Desain Poster Acara', subtitle: 'Cocok dengan keahlian desain grafis', price: 'Rp 75.000'),
          _buildJobRecommendationCard(context, title: 'Asisten Riset Psikologi', subtitle: 'Populer untuk mahasiswa Psikologi', price: 'Rp 60.000'),
          const SizedBox(height: 20),
          _buildSectionHeader(context, icon: Icons.bookmark_outline, title: 'Paket Lainnya', isNew: false),
          _buildPackageCard(context, title: 'Tutor 3 Mata Kuliah', originalPrice: 'Rp 150.000', discountedPrice: 'Rp 120.000', discount: '20% off'),
          _buildPackageCard(context, title: 'Tutor 2 Mata Kuliah', originalPrice: 'Rp 120.000', discountedPrice: 'Rp 93.500', discount: '22% off'),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filter Pintar', style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              Switch(value: true, onChanged: (bool value) {}, activeThumbColor: Theme.of(context).colorScheme.surface, activeTrackColor: Theme.of(context).colorScheme.secondary, inactiveThumbColor: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          _buildFilterButton(context, icon: Icons.calendar_today, label: 'Hanya Akhir Pekan', onTap: () {}),
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
    );
  }

  Widget _buildFilterButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final bool isWide = !label.contains(':');
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: isWide ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: isWide ? Border.all(color: Colors.grey[300]!) : null,
          ),
          child: Row(
            mainAxisAlignment: isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
              if (isWide) const SizedBox(width: 10),
              Flexible(child: Text(label, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required IconData icon, required String title, required bool isNew}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 8),
          Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          if (isNew) ...[const SizedBox(width: 8), _buildNewTag(context)],
        ],
      ),
    );
  }

  Widget _buildNewTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(5)),
      child: Text('Baru', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildJobRecommendationCard(BuildContext context, {required String title, required String subtitle, required String price}) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/job-detail');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [Flexible(child: Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold))), const SizedBox(width: 8), _buildNewTag(context)]),
                  const SizedBox(height: 4),
                  Text(subtitle, style: textTheme.bodyMedium!.copyWith(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Text(price, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context, {required String title, required String originalPrice, required String discountedPrice, required String discount}) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(originalPrice, style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.grey[500], decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 5),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(5)), child: Text(discount, style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 4),
              Text(discountedPrice, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
            ],
          ),
        ],
      ),
    );
  }
}