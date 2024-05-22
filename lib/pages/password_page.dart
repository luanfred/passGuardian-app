import 'package:app_faculdade/components/card_password.dart';
import 'package:app_faculdade/models/password_model2.dart';
import 'package:flutter/material.dart';

import '../services/password_service.dart';
import '../theme/app_colors.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late Future<List<PasswordModel2>> passwordList;

  @override
  void initState() {
    super.initState();
    passwordList = getPassList();
  }

  Future<List<PasswordModel2>> getPassList() async {
    return await PasswordService().getAllPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'PassGuardian',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: FutureBuilder<List<PasswordModel2>>(
        future: passwordList,
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
                      ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ThemeColors.blueButton,
        onPressed: () {
          Navigator.pushNamed(context, '/registerPassword');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
