import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String iconPath;
  final String role;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.iconPath,
    required this.role,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 70,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, size: 70, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              role,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 5),
            const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
