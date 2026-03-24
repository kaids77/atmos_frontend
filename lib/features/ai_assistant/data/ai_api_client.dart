import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:atmos_frontend/core/config/api_config.dart';
import 'package:atmos_frontend/core/auth/auth_state.dart';

class AiApiClient {
  String get _userId => AuthState().userEmail ?? 'anonymous_user';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/api/ai/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': _userId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Sorry, I couldn\'t process that.';
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error connecting to AI service. Please try again.';
    }
  }

  Future<List<Map<String, dynamic>>> getChatHistory() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/ai/history?userId=$_userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['history'] ?? []);
      }
      return [];
    } catch (e) {
      print('Error fetching history: $e');
      return [];
    }
  }

  Future<bool> deleteConversation() async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/api/ai/history?userId=$_userId'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting conversation: $e');
      return false;
    }
  }
}
