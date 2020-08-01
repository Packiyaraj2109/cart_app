import 'dart:convert';
import 'package:cart_app/src/config/app_config.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  Map headers = <String, String>{
    'Accept': 'application/json',
  };

  Future<Map> getMethod(String subUrl) async {
    String mainUrl = AppConfig.baseUrl + subUrl;
    final response = await http.get(
      mainUrl,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('not loaded');
    }
  }

  Future<Map> postMethod(String subUrl, dynamic payload) async {
    String mainUrl = AppConfig.baseUrl + subUrl;
    final response = await http.post(
      mainUrl,
      headers: headers,
      body: json.encode(payload),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('not loaded');
    }
  }
}
