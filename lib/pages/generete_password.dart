import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GenetePassword extends StatefulWidget {
  const GenetePassword({super.key});

  @override
  State<GenetePassword> createState() => _GenetePasswordState();
}

class _GenetePasswordState extends State<GenetePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
            'Gerar Senha',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
    );
  }
}
