import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:async'; // Diperlukan untuk Timer

// Ubah menjadi StatefulWidget
class OtpVerificationScreen extends StatefulWidget {
  final String contactInfo;

  const OtpVerificationScreen({super.key, required this.contactInfo});

  @override
  // ignore: library_private_types_in_public_api
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // Waktu awal timer (30 detik)
  static const int _start = 30; 
  int _current = _start;
  // Inisialisasi Timer secara aman untuk mencegah LateError
  Timer _timer = Timer(Duration.zero, () {}); 
  
  // Fungsi utilitas untuk masking (menyembunyikan sebagian) kontak
  String _maskContact(String contact) {
    if (contact.isEmpty) return "Kontak tidak valid";

    if (contact.contains('@')) {
      final parts = contact.split('@');
      if (parts.length == 2) {
        final username = parts[0];
        final domain = parts[1];
        final maskedUsername = username.length > 1
            ? '${username.substring(0, 1)}*******${username.substring(username.length - 1)}'
            : '$username******';
        return '$maskedUsername@$domain';
      }
    }

    if (contact.length > 5) {
      final start = contact.substring(0, 3);
      final end = contact.substring(contact.length - 3);
      final maskedPart = '********';
      return '$start$maskedPart$end';
    }

    return contact;
  }

  // --- Logika Timer ---
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dihentikan saat widget dihapus
    super.dispose();
  }

  void startTimer() {
    _current = _start; // Setel ulang ke 30
    const oneSec = Duration(seconds: 1);
    
    // Batalkan timer sebelumnya jika aktif
    if (_timer.isActive) {
      _timer.cancel();
    }
    
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (!mounted) return; // Cek mounted untuk menghindari error jika widget dihapus
        if (_current == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _current--;
          });
        }
      },
    );
  }

  // Format waktu 00:30, 00:29, dst.
  String get timerText => '00:${_current.toString().padLeft(2, '0')}';
  // --- Akhir Logika Timer ---

  @override
  Widget build(BuildContext context) {
    final maskedContact = _maskContact(widget.contactInfo);
    // Tombol Kirim Ulang hanya aktif jika _current == 0
    final isTimerActive = _current > 0;
    
    // Hitungan padding dinamis untuk mengatasi overflow keyboard
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface),
          onPressed: () => Navigator.pop(context),
        ),
        // MEMASUKKAN ASET LOGO
        title: Image.asset('assets/logo.png', height: 150), 
        centerTitle: true,
      ),
      // MENGATASI OVERFLOW DENGAN SingleChildScrollView
      body: SingleChildScrollView(
        // Padding dinamis di bagian bawah untuk memastikan tombol tetap terlihat
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + viewInsets), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Verifikasi OTP",
                // MENGGUNAKAN THEME: bodyLarge (14) + override size 15, color black, dan bold
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            SizedBox(height: 30),

            Text(
              "Masukkan kode verifikasi Anda",
              textAlign: TextAlign.center,
              // MENGGUNAKAN THEME: bodyLarge (14) + override size 16 dan color black
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
            ),
            Text(
              "Periksa pesan dari email/telepon Anda",
              textAlign: TextAlign.center,
              // MENGGUNAKAN THEME: bodyLarge (14) + override color white70
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70),
            ),
            Text(
              maskedContact, 
              textAlign: TextAlign.center,
              // MENGGUNAKAN THEME: bodyLarge (14) + override color white
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
            SizedBox(height: 40),

            // MEMASUKKAN ASET ILUSTRASI
            Center(
              child: Image.asset('assets/otp_illustration.png', height: 100),
            ),
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    // MENGGUNAKAN THEME: displayMedium (24) + override color black
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // TIMER KIRIM ULANG
            Center(
              child: GestureDetector(
                onTap: isTimerActive ? null : startTimer, // Hanya aktif jika timer == 0
                child: Text(
                  isTimerActive
                      ? "Kirim ulang dalam $timerText" // Tampilkan timer
                      : "Kirim Ulang Kode",           // Tampilkan tombol teks
                  // MENGGUNAKAN THEME: bodyLarge (14) + override color dan decoration
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isTimerActive ? Colors.white70 : Theme.of(context).colorScheme.secondary,
                    decoration: isTimerActive ? TextDecoration.none : TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                context.push('/select-role');
              },
              child: Text(
                "Selanjutnya",
                // MENGGUNAKAN THEME: labelLarge (16) + override size 18
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}