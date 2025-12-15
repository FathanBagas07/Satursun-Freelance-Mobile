import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  final String baseUrl = 'https://api-kamu.com/api';

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String role,
  }) async {
    final token = await authService.getIdToken();

    if (token == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'role': role,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register user');
    }
  }
}

final apiService = ApiService();