import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatResult {
  final String sessionId;
  final String message;

  ChatResult({
    required this.sessionId,
    required this.message,
  });
}

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8001';

  static Future<ChatResult> sendMessage({
    required String userId,
    required String message,
    String? sessionId,
  }) async {
    final uri = Uri.parse('$baseUrl/chat');

    try {
      final response = await http.post(
        uri,
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

        final returnedSessionId =
            data['session_id']?.toString() ?? '';

        final responseData = data['response'];

        String aiMessage;

        if (responseData is Map &&
            responseData['response'] != null) {
          aiMessage = responseData['response'].toString();
        } else {
          aiMessage = responseData.toString();
        }

        return ChatResult(
          sessionId: returnedSessionId,
          message: aiMessage,
        );
      }

      throw Exception(
        'Backend error: ${response.statusCode} ${response.body}',
      );
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}