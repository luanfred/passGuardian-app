import 'package:flutter/material.dart';

import '../components/card_password.dart';
import '../models/password_model2.dart';
import '../services/password_service.dart';
import '../theme/app_colors.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<PasswordModel2>> passwordFavoritesList;

  Future<List<PasswordModel2>> getPassFavoritesList() async {
    return await PasswordService().getAllPasswordsFavorites();
  }

  @override
  void initState() {
    super.initState();
    passwordFavoritesList = getPassFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: FutureBuilder<List<PasswordModel2>>(
        future: passwordFavoritesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Nenhuma senha encontrada'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final password = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Card.outlined(
                    child: CardPassword(
                      title: password.title,
                      email: password.email,
                      passwordId: password.passwordId,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
