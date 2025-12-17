import 'package:flutter/material.dart';
import 'package:satursun_app/modules/client/services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _service;

  ProfileController(this._service);

  bool isLoading = true;
  String fullName = 'Memuat...';
  String role = 'Klien';
  String? photoUrl;

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    final data = await _service.fetchUserProfile();
    if (data != null) {
      final first = data['firstName'] ?? '';
      final last = data['lastName'] ?? '';

      fullName =
          '$first $last'.trim().isEmpty ? 'User Tanpa Nama' : '$first $last';

      role = data['role'] ?? 'Klien';
      photoUrl = data['photoUrl'];
    }

    isLoading = false;
    notifyListeners();
  }
}