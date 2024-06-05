import 'package:app_faculdade/services/user_service.dart';
import 'package:app_faculdade/theme/app_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_settings.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  final _nameUser = TextEditingController();
  final _cpfUser = TextEditingController();
  final _emailUser = TextEditingController();
  bool _isLoading = true;

  logout(context) async {
    await AppSettings().deleteUserData();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  getInfoUser() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    var credentials = await UserService().getUserById(userId!);
    print(credentials);
    setState(() {
      _nameUser.text = credentials['name'];
      _cpfUser.text = credentials['cpf'];
      _emailUser.text = credentials['username'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getInfoUser();
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
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) :
      Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 35.0,
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: TextFormField(
                  controller: _nameUser,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  readOnly: true,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: TextFormField(
                  controller: _cpfUser,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um CPF';
                    }
                    return null;
                  },
                  readOnly: true,
                  maxLength: 14,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: TextFormField(
                  controller: _emailUser,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail';
                    }
                    String pattern = r'^[^@]+@[^@]+\.[^@]+';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                  readOnly: true,
                  maxLength: 50,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
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
            ],
          ),
        ),
      );
  }
}
