import 'package:flutter/material.dart';
import 'package:swifty_companion/models/user.model.dart';
import 'package:swifty_companion/modules/api_42.dart';
import 'package:swifty_companion/modules/secure_storage.dart';
import 'package:swifty_companion/views/home/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/coalition.model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _isSpin = false;
  late WebViewController controller;

  _LoginScreenState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith('swifty://')) {
              setState(() {
                _isLoading = false;
                _isSpin = true;
              });
              final code = Uri.parse(request.url).queryParameters['code'];
              await Api42.generateToken(code: code);
              final User? user = await Api42.getUser();
              if (user == null) {
                return NavigationDecision.prevent;
              }
              final Coalition? userCoalition =
                  await Api42.getCoalition(user.login);
              if (userCoalition == null) {
                return NavigationDecision.prevent;
              }
              await SecureStorage.write('user', user.toJson());
              if (await SecureStorage.read('access_token') != null) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                          currentUser: user, userCoalition: userCoalition),
                    ),
                  );
                }
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swifty Companion'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
              controller.loadRequest(Api42.authorizeUri);
            });
          },
          child: _isLoading
              ? WebViewWidget(controller: controller)
              : _isSpin
                  ? const Text('Loading ...')
                  : const Text('Login'),
        ),
      ),
    );
  }
}
