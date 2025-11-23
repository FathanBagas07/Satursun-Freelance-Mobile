import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunGreen = Color(0xFF4CAF50);

class WalletScreenFreelancer extends StatelessWidget {
  const WalletScreenFreelancer({super.key});

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
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Saldo', style: textTheme.displayMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          const SizedBox(height: 15),
          _buildBalanceCard(context),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Tarik Sekarang', style: textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const SizedBox(height: 15),
          _buildWithdrawalCard(context),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Hadiah', style: textTheme.titleLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const SizedBox(height: 15),
          _buildRewardsCard(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home-freelancer');
              },
            ),
            Text('SaturSun Freelance', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Penghasilan Mei 2025', style: textTheme.bodyMedium!.copyWith(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rp 1.250.000', style: textTheme.displayMedium!.copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: _saturSunBlue)),
              const SizedBox(width: 8),
              Row(children: [Icon(Icons.arrow_upward, color: _saturSunGreen, size: 16), Text('12% vs bulan lalu', style: textTheme.bodyMedium!.copyWith(color: _saturSunGreen, fontSize: 14))]),
            ],
          ),
          const SizedBox(height: 20),
          Text('Komisi Tertahan', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
          const SizedBox(height: 5),
          Text('Akan cair setelah job selesai', style: textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildWithdrawalCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pembayaran Instan', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [_buildEWalletIcon(context, 'DANA', Colors.blue), const SizedBox(width: 10), _buildEWalletIcon(context, 'gopay', Colors.green), const SizedBox(width: 10), _buildEWalletIcon(context, 'OVO', Colors.purple), const SizedBox(width: 10), _buildEWalletIcon(context, '...', Colors.grey)]),
          const SizedBox(height: 5),
          Text('Rp 2.500/transaksi', style: textTheme.bodySmall!.copyWith(fontSize: 12, color: _saturSunOrange, fontWeight: FontWeight.w600)),
          const Divider(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Bank Transfer', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)), GestureDetector(onTap: () {}, child: Text('pilih bank >', style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: _saturSunBlue, fontWeight: FontWeight.w600)))]),
          const SizedBox(height: 10),
          Row(children: [_buildTransferOption(context, 'Standar (2 hari)', isSelected: true), const SizedBox(width: 15), _buildTransferOption(context, 'Kilat (1 jam)', isSelected: false)]),
        ],
      ),
    );
  }

  Widget _buildEWalletIcon(BuildContext context, String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(name, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color, fontWeight: FontWeight.bold, fontSize: 14))),
    );
  }

  Widget _buildTransferOption(BuildContext context, String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: isSelected ? _saturSunLightBlue : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? _saturSunGreen : Colors.grey, size: 18), const SizedBox(width: 5), Text(label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: isSelected ? _saturSunBlue : Colors.grey[700], fontSize: 13))]),
    );
  }

  Widget _buildRewardsCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kupon', style: textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildCouponItem(context, 'Kerjakan 20 job (Kupon Skill Academy 40K)', current: 3, target: 20),
          _buildCouponItem(context, 'Kerjakan 15 job (Voucher)', current: 5, target: 15),
        ],
      ),
    );
  }

  Widget _buildCouponItem(BuildContext context, String description, {required int current, required int target}) {
    double progress = current / target;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Flexible(child: Text(description, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500))), Text('$current/$target', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: progress >= 1.0 ? _saturSunGreen : _saturSunOrange))]),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange), minHeight: 5),
        ],
      ),
    );
  }
}