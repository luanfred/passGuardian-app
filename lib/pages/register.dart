import 'package:app_faculdade/models/user_model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_service.dart';
import '../theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final _nameUser = TextEditingController();
  final _cpfUser = TextEditingController();
  final _emailUser = TextEditingController();
  final _passwordUser = TextEditingController();
  final _confirmPasswordUser = TextEditingController();

  void saveUser() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    UserModel user = UserModel(
        cpf: _cpfUser.text,
        name: _nameUser.text,
        username: _emailUser.text,
        password: _passwordUser.text
    );
    var response = await UserService().saveUser(user);
    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/');
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário já cadastrado'),
        ),
      );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao salvar usuário'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
            'Cadastre-se',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ThemeColors.blueText,
            )
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Text(
                'Bem vindo ao PassGuardian!',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.blueText,
                )
            ),
            Form(
              key: _form,
                child: Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 17.0,
                      left: 8.0,
                      right: 8.0
                  ),
                  child: TextFormField(
                    controller: _passwordUser,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a Senha mestre';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                    maxLength: 50,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'Senha Mestre',
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
                    controller: _confirmPasswordUser,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme a Senha Mestre';
                      }
                      if (value != _passwordUser.text) {
                        return 'As senhas não conferem';
                      }
                      return null;
                    },
                    maxLength: 50,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'Confirme a Senha Mestre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
            Padding(
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
                      onPressed: () {saveUser();},
                      child: Text(
                        'Registrar-se',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
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
          ],
        ),
      ),
    );
  }
}
