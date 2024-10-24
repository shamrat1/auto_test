import 'dart:convert';
import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String baseUrl =
      'http://yasin-shamrat.com/api/'; // Replace with your API base URL

  // Helper method to make a GET request
  static Future<dynamic> get(String endpoint) async {
    print(Uri.parse('$baseUrl$endpoint'));
    print(_getHeaders());
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: _getHeaders());
    // print(response.statusCode);
    // print(response.body);
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data,
      {String? contentType}) async {
    print('$baseUrl$endpoint');
    print(data);
    print(contentType);
    print(_getHeaders());
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _getHeaders(),
      body: data,
    );
    print(response.statusCode);
    print(response.body);
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: _getHeaders(),
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders());
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('${response.statusCode}\n${response.body}');
    }
  }

  static Map<String, String>? _getHeaders() {
    var token = Get.find<AuthenticationController>().response.value.token;
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
        "Accept": "applicatino/json",
      };
    }
    return {
      "Accept": "application/json",
    };
  }
}
