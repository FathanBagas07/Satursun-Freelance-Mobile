import 'package:flutter/material.dart';
import 'package:satursun_app/modules/client/services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _service;

  ProfileController(this._service);

  bool loading = true;
  String fullName = '';
  String role = '';
  String? photoUrl;

  /// 🔹 Ambil data user
  Future<void> loadProfile() async {
    loading = true;
    notifyListeners();

    final data = await _service.fetchUserProfile();
    if (data != null) {
      final first = data['firstName'] ?? '';
      final last = data['lastName'] ?? '';

      fullName = '$first $last'.trim().isEmpty
          ? 'User Tanpa Nama'
          : '$first $last'.trim();

      role = data['role'] ?? 'Klien';
      photoUrl = data['photoUrl'];
    }

    loading = false;
    notifyListeners();
  }

  /// 🔹 Update foto + refresh state
  Future<void> setProfilePhoto(String url) async {
    await _service.updateProfilePhoto(url);
    photoUrl = url;
    notifyListeners();
  }
}
