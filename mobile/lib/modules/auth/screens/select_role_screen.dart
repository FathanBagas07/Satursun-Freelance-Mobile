import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/auth_service.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  bool _isLoading = false;

  Future<void> _handleRoleSelection(String role) async {
    setState(() => _isLoading = true);
    
    try {
      final user = authService.currentUser;
      if (user != null) {
        // 1. Simpan Role ke Firestore
        await authService.updateUserRole(user.uid, role);

        // 2. Logout (Sign Out) agar user masuk kembali
        await authService.signOut();

        if (!mounted) return;

        // 3. Arahkan ke Login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dibuat. Silakan login kembali.')),
        );
        context.go('/sign-in'); 
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: const Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/logo.png', height: 40),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Pilih Peran",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              "Silahkan pilih peran Anda",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Peran yang Anda pilih tidak dapat diganti setelah pendaftaran selesai",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleCard(
                    context, 'assets/freelancer_icon.png', "Freelancer"),
                _buildRoleCard(context, 'assets/client_icon.png', "Klien"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String iconPath, String role) {
    return GestureDetector(
      onTap: () => _handleRoleSelection(role),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 140,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath, 
                height: 70,
                errorBuilder: (c,e,s) => const Icon(Icons.person, size: 70, color: Colors.grey),
              ), 
              const SizedBox(height: 10),
              Text(
                role,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 5),
              const Icon(Icons.arrow_forward, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}