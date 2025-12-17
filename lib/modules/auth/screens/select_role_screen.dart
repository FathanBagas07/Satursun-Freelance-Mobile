import 'package:flutter/material.dart';
import 'package:satursun_app/core/services/user_service.dart';
import 'package:satursun_app/modules/auth/widgets/role_card.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(child: Image.asset('assets/logo.png', height: 170)),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Pilih Peran",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Silahkan pilih peran Anda",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // ← ini yang membuat bold
                ),
              ),

              Text(
                "Peran yang Anda pilih tidak dapat diganti setelah pendaftaran selesai",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoleCard(
                    iconPath: 'assets/icons/freelancer.png',
                    role: 'Freelancer',
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);

                      try {
                        await userService.setRoleOnce('Freelancer');
                      } catch (e) {
                        if (!mounted) return;
                        messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  RoleCard(
                    iconPath: 'assets/icons/client.png',
                    role: 'Klien',
                    onTap: () async {
                      final messenger = ScaffoldMessenger.of(context);

                      try {
                        await userService.setRoleOnce('Klien');
                      } catch (e) {
                        if (!mounted) return;
                        messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}