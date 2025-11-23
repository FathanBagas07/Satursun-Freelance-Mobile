import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunOrange = Color(0xFFF98B00);
const Color _saturSunBlue = Color(0xFF1E88E5);
const Color _saturSunLightBlue = Color(0xFFD3E0F0);
const Color _saturSunRed = Color(0xFFE53935); 

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

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
                colors: [
                  _saturSunBlue,
                  _saturSunLightBlue,
                ],
                stops: [0.0, 0.25],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Transform.translate(
          offset: const Offset(0, 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/task-list-freelancer');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _saturSunRed,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
            child: Text(
              'Kerjakan',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desain Webinar :',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Desain Poster Acara Webinar Nasional',
                  style: textTheme.headlineMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Diposting Oleh : BEM Fasilkom-TI USU',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: _buildInfoCard(context,
                            Icons.calendar_today, 'Tenggat :', '10 Hari')),
                    const SizedBox(width: 15),
                    Expanded(
                        child: _buildInfoCard(context, Icons.payment, 'Bayaran :',
                            'Rp 75.000', _saturSunOrange)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi Pekerjaan',
                  style: textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Kami dari BEM Fasilkom-TI USU membutuhkan seorang desainer grafis untuk membuat poster acara "Webinar Nasional: AI for Future Generation". Desain diharapkan terlihat modern, profesional, dan sesuai dengan tema teknologi.',
                  style: textTheme.bodyMedium!.copyWith(fontSize: 15, height: 1.4),
                ),
                const SizedBox(height: 15),
                Text(
                  'Detail yang harus ada di poster:',
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint(context, 'Judul Acara & Tema'),
                _buildBulletPoint(context, 'Nama dan foto 2 orang pembicara'),
                _buildBulletPoint(context, 'Waktu & Tanggal Pelaksanaan'),
                _buildBulletPoint(context, 'Platform (Zoom Meeting)'),
                _buildBulletPoint(context, 'Link Pendaftaran'),
                _buildBulletPoint(context, 'Logo Universitas dan BEM'),
                const SizedBox(height: 15),
                Text(
                  'Keahlian yang Dibutuhkan',
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint(context,
                    'Menguasai software desain (Canva, Figma, Adobe Photoshop, CorelDRAW, dll.)'),
                _buildBulletPoint(context,
                    'Memiliki pemahaman yang baik tentang tata letak dan tipografi.'),
              ],
            ),
          ),
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
                Navigator.pop(context);
              },
            ),
            Text(
              'SaturSun Freelance',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      IconData icon, String label, String value,
      [Color valueColor = Colors.black]) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _saturSunBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: textTheme.displaySmall!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: textTheme.bodyMedium!.copyWith(fontSize: 15)),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium!.copyWith(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}