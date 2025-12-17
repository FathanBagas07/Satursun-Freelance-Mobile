import 'package:flutter/material.dart';
import 'package:satursun_app/modules/auth/enums/policy_type.dart';

class PolicyDialog extends StatelessWidget {
  final PolicyType type;

  const PolicyDialog({super.key, required this.type});

  String get _title {
    switch (type) {
      case PolicyType.terms:
        return 'Ketentuan Pengguna';
      case PolicyType.privacy:
        return 'Kebijakan Privasi';
    }
  }

  String get _content {
    switch (type) {
      case PolicyType.terms:
        return '''
Selamat datang di Satursun Freelance.

Dengan menggunakan aplikasi ini, Anda setuju untuk:
1. Menggunakan layanan secara bertanggung jawab
2. Tidak menyalahgunakan fitur aplikasi
3. Menjaga etika dan profesionalisme
4. Mematuhi hukum yang berlaku
''';

      case PolicyType.privacy:
        return '''
Kami menghargai privasi Anda.

Data yang kami kumpulkan:
- Nama dan email
- Informasi akun

Data digunakan untuk:
- Autentikasi pengguna
- Peningkatan layanan

Kami tidak membagikan data Anda tanpa izin.
''';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Text(_content, style: const TextStyle(fontSize: 14)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
