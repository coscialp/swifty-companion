import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

class Request {
  static Future<dynamic> get(Uri uri, {Map<String, String>? headers}) async {
    final response = await http.get(uri, headers: headers);

    // dev.log(response.body);

    if (response.statusCode != 200) {
      throw http.ClientException(
          'Error while fetching data with status code: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }
}
