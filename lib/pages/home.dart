import 'package:app_faculdade/config/app_settings.dart';
import 'package:app_faculdade/pages/favorite.dart';
import 'package:app_faculdade/pages/generete_password.dart';
import 'package:app_faculdade/pages/logout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_colors.dart';
import 'password_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageActive = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageActive);
    UserIsLogged();
  }

  setPageActive(int page) {
    setState(() {
      pageActive = page;
    });
  }

  UserIsLogged() async {
    var credentials = await AppSettings().readUserData();
    bool isFromLogin = false;
    try {
      isFromLogin = ModalRoute.of(context)?.settings.arguments as bool ?? false;
    } catch (e) {
      print('Error: $e');
    }
    if (credentials['isChecked'] == false && isFromLogin == false) {
      await AppSettings().deleteUserData();
      credentials = await AppSettings().readUserData();
    }
    if (credentials['username'] == '' && credentials['password'] == '' && credentials['userId'] == 0 && isFromLogin == false) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: PageView(
        controller: pageController,
        children: const [
          PasswordPage(),
          FavoritePage(),
          GeneratePassword(),
          LogoutPage(),
        ],
        onPageChanged: (page) {setPageActive(page);},
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageActive,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_outline),
            label: 'Gerar Senha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Sair',
          ),
        ],
        onTap: (page) {
          pageController.animateToPage(
              page,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
          );
        },
        selectedItemColor: ThemeColors.blueButton,
        unselectedItemColor: ThemeColors.blueText,
      ),
    );
  }
}
