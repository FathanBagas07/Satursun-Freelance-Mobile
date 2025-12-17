import 'package:flutter/material.dart';
import 'package:satursun_app/core/services/user_service.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key});

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return AlertDialog(
      title: const Text('Ubah Kata Sandi'),
      content: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(hintText: 'Masukkan email Anda'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _loading
              ? null
              : () async {
                  final email = _emailController.text.trim();
                  if (email.isEmpty) return;

                  setState(() => _loading = true);

                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  try {
                    await userService.sendPasswordResetEmail(email);

                    if (!mounted) return;

                    navigator.pop();

                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Link reset sandi telah dikirim ke email',
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;

                    messenger.showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  } finally {
                    if (mounted) {
                      setState(() => _loading = false);
                    }
                  }
                },
          child: _loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Kirim'),
        ),
      ],
    );
  }
}
