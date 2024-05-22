import 'package:app_faculdade/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  logout(context) async {
    await AppSettings().deleteUserData();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
            'Perfil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Stack(
            children: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColors.blueButton,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: () {
                    logout(context);
                  },
                  child: Text(
                    'Sair',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 307,
                right: 10,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: ThemeColors.blueButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
