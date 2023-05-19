import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swifty_companion/modules/api_42.dart';
import 'package:swifty_companion/modules/secure_storage.dart';

class Request {
  static Future<dynamic> get(Uri uri,
      {required Map<String, String> headers}) async {
    for (var i = 0; i < 3; i++) {
      try {
        final response = await http.get(uri, headers: headers);

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 401) {
          throw http.ClientException(
              'Error while fetching data with status code: ${response.statusCode}');
        } else if (response.statusCode == 429) {
          throw http.ClientException(
              'Error while fetching data with status code: ${response.statusCode}');
        } else {
          throw http.ClientException(
              'Error while fetching data with status code: ${response.statusCode}');
        }
      } catch (e) {
        if (e.toString().contains('429')) {
          await Future.delayed(const Duration(seconds: 1));
        } else if (e.toString().contains('401')) {
          await Api42.generateToken();
          headers['Authorization'] =
              'Bearer ${await SecureStorage.read('access_token')}';
        } else {
          rethrow;
        }
      }
    }
  }
}
