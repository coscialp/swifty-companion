import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/models/coalition.model.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/modules/request.dart';
import 'package:swifty_companion/modules/secure_storage.dart';

class Api42 {
  static const String _baseUrl = 'api.intra.42.fr';
  static final String _clientId = dotenv.env['CLIENT_ID']!;
  static final String _clientSecret = dotenv.env['CLIENT_SECRET']!;
  static final String _redirectUri = dotenv.env['REDIRECT_URI']!;
  static late String _authenticateCode;

  static get authorizeUri {
    return Uri.https(_baseUrl, '/oauth/authorize', {
      'client_id': _clientId,
      'redirect_uri': _redirectUri,
      'response_type': 'code',
      'scope': 'public',
    });
  }

  static Future<void> generateToken({String? code}) async {
    if (code != null) {
      await SecureStorage.write('authenticateCode', code);
    }
    _authenticateCode =
        (await SecureStorage.read('authenticateCode')).toString();
    debugPrint(_authenticateCode);
    final url = Uri.https(_baseUrl, 'oauth/token');

    final response = await http.post(url, body: {
      'grant_type': 'authorization_code',
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'redirect_uri': _redirectUri,
      'code': _authenticateCode,
    });

    final responseJson = jsonDecode(response.body);
    final String accessToken = responseJson['access_token'];

    await SecureStorage.write('access_token', accessToken);
  }

  static Future<User?> getUser({String login = 'me'}) async {
    final accessToken = await SecureStorage.read('access_token');
    try {
      final response = await Request.get(
        Uri.https(_baseUrl, login == 'me' ? '/v2/me' : '/v2/users/$login'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      final User user = User.fromJson(response);

      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<List<String>> searchUserByLogin(String query) async {
    final accessToken = await SecureStorage.read('access_token');

    try {
      final response = await Request.get(
        Uri.parse(
            'https://$_baseUrl/v2/users?range[login]=$query,${query}zzzzz'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      log(response.toString(), name: 'searchUserByLogin');

      final List<String> users = response
          .map<String>((user) => user['login'] as String)
          .toList(growable: false);

      return users;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<Coalition?> getCoalition(String username) async {
    final accessToken = await SecureStorage.read('access_token');

    try {
      final response = await Request.get(
        Uri.parse('https://$_baseUrl/v2/users/$username/coalitions'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      return Coalition.fromJson(response[0]);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
