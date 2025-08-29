import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/http_constant.dart';

class ApiService {

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Failed API call: ${response.statusCode} - ${response.body}");
    }
  }
}
