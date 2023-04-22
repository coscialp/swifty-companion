import 'package:flutter/material.dart';
import 'package:swifty_companion/views/login/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const SwiftyCompanion());
}

class SwiftyCompanion extends StatelessWidget {
  const SwiftyCompanion({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Swifty Companion',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF2E3440,
          <int, Color>{
            50: Color(0xFF2E3440),
            100: Color(0xFF2E3440),
            200: Color(0xFF2E3440),
            300: Color(0xFF2E3440),
            400: Color(0xFF2E3440),
            500: Color(0xFF2E3440),
            600: Color(0xFF2E3440),
            700: Color(0xFF2E3440),
            800: Color(0xFF2E3440),
            900: Color(0xFF2E3440),
          },
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
