import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar_klien.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);

class ProfileKlienScreen extends StatelessWidget {
  const ProfileKlienScreen({super.key});

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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home-freelancer');
                    }),
                Text(
                  'Satursun Freelance',
                  style: textTheme.titleLarge!.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/profile_pic.png'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monica Raquella',
                        style: textTheme.headlineMedium!.copyWith(
                            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Klien  |  4.8 (32 reviews)',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.folder_special_outlined, color: Colors.black, size: 24),
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
                  style: textTheme.bodyLarge!
                      .copyWith(fontSize: 16, color: _saturSunBlue, fontWeight: FontWeight.w600),
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
                const Icon(Icons.cloud_upload_outlined, color: _saturSunBlue, size: 28),
                const SizedBox(width: 20),
                Text(
                  'Upload Portofolio rekrutmen\n (max 5MB)',
                  style: textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.w500),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
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
                  const Icon(Icons.visibility_off_outlined, color: _saturSunOrange, size: 22),
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
                activeThumbColor: Colors.white,
                activeTrackColor: _saturSunOrange,
                inactiveThumbColor: Colors.grey,
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Auto Reply: "Saat ini saya sedang membuka rekrutmen secara privat. Hanya kandidat terpilih yang akan dihubungi."',
            style: textTheme.bodyMedium!.copyWith(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPlaceholderImage(context, 1),
              _buildPlaceholderImage(context, 2),
              _buildPlaceholderImage(context, 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context, int index) {
    return Container(
      width: 70,
      height: 70,
      color: _saturSunLightBlue.withValues(alpha: 0.5),
      child: Center(
        child: Text(
          'Ilustrasi $index',
          style: Theme.of(context).textTheme.bodySmall!
              .copyWith(fontSize: 10, color: _saturSunBlue),
        ),
      ),
    );
  }

  Widget _buildActivitySection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.bar_chart, color: Colors.black, size: 24),
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
              Text('5 Unggah Pekerjaan',
                  style: textTheme.bodyMedium!.copyWith(fontSize: 15, color: _saturSunBlue)),
              Text('3 Orang di Rekrut',
                  style: textTheme.bodyMedium!.copyWith(fontSize: 15, color: Colors.black)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(_saturSunOrange),
            minHeight: 5,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Blokir notifikasi Senin–Jumat',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 15)),
              Switch(
                value: true,
                onChanged: (bool value) {},
                activeThumbColor: Colors.white,
                activeTrackColor: _saturSunOrange,
                inactiveThumbColor: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
  }
}
