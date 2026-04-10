import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class WeatherUpdate {
  final String id;
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  WeatherUpdate({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory WeatherUpdate.fromJson(Map<String, dynamic> json) {
    return WeatherUpdate(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}

class NewsApiService {
  final String _baseUrl = '${ApiConfig.baseUrl}/api/news';

  Future<List<WeatherUpdate>> fetchUpdates() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => WeatherUpdate.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load updates: ${response.body}');
    }
  }

  Future<WeatherUpdate> createUpdate(WeatherUpdate update) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(update.toJson()),
    );
    if (response.statusCode == 200) {
      return WeatherUpdate.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create update: ${response.body}');
    }
  }

  Future<WeatherUpdate> editUpdate(String id, WeatherUpdate update) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(update.toJson()),
    );
    if (response.statusCode == 200) {
      return WeatherUpdate.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to edit update: ${response.body}');
    }
  }

  Future<void> deleteUpdate(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete update: ${response.body}');
    }
  }
}
