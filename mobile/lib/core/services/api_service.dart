import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  final String baseUrl = 'https://api-kamu.com/api';

  Future<void> registerUser({
    required String displayName,
    required String username,
    required String email,
  }) async {
    final token = await authService.getIdToken();

    if (token == null) {
      throw Exception('Pengguna Belum Terautentikasi');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'display_name': displayName,
        'username': username,
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal Mendaftarkan Pengguna');
    }
  }
}

final apiService = ApiService();
