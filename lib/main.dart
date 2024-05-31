import 'package:app_faculdade/pages/edit_password.dart';
import 'package:app_faculdade/pages/home.dart';
import 'package:app_faculdade/pages/login.dart';
import 'package:app_faculdade/pages/query_password.dart';
import 'package:app_faculdade/pages/register.dart';
import 'package:app_faculdade/pages/register_password.dart';
import 'package:app_faculdade/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'config/app_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeColors.blueButton,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: ThemeColors.blueText,
          displayColor: ThemeColors.blueText,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/registerPassword': (context) => const RegisterPasswordPage(),
        '/editPassword': (context) => const EditPasswordPage(),
      },
      builder: (context, child) {
        return SafeArea(
          child: child!,
        );
      },
    );
  }
}
