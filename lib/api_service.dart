import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Flutter Web / Edge
static const String baseUrl = 'http://127.0.0.1:8001';
  static Future<String> sendMessage({
    required String userId,
    required String message,
    String? sessionId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'message': message,
        'session_id': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response']['response'];
    }

    throw Exception(
      'Backend error: ${response.statusCode} ${response.body}',
    );
  }
}