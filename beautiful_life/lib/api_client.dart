import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load todos: ${response.statusCode}');
    }
  }
}