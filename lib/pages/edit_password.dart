import 'dart:ui';

import 'package:app_faculdade/pages/query_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/password_model2.dart';
import '../services/password_service.dart';
import '../theme/app_colors.dart';
import 'generete_password.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Recupera os argumentos passados pela navegação
    final PasswordModel2 passwordModel = ModalRoute.of(context)!.settings.arguments as PasswordModel2;
    return EditPassword(passwordModel: passwordModel);
  }
}


class EditPassword extends StatefulWidget {
  const EditPassword({super.key, required this.passwordModel});

  final PasswordModel2 passwordModel;

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _passwordOrNameApp = TextEditingController();
  late String _favorite = '';
  bool _obscureText = true;

  getInfoPassword() {
    _title.text = widget.passwordModel.title;
    _username.text = widget.passwordModel.email;
    _password.text = widget.passwordModel.password;
    _passwordOrNameApp.text = widget.passwordModel.url;
    _favorite = widget.passwordModel.favorite;
  }

  savePassword() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    print('Título: ${_title.text}');
    print('E-mail ou nome de usuário: ${_username.text}');
    print('Senha: ${_password.text}');
    print('URL do site ou nome do aplicativo: ${_passwordOrNameApp.text}');
    print('Favorito: $_favorite');
    PasswordModel2 passwordModel = PasswordModel2(
      passwordId: widget.passwordModel.passwordId,
      title: _title.text,
      url: _passwordOrNameApp.text,
      email: _username.text,
      password: _password.text,
      favorite: _favorite,
    );
    var response = await PasswordService().updatePassword(passwordModel);
    print("Response: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senha salva com sucesso'),
        ),
      );
      Navigator.pop(context, passwordModel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao salvar senha'),
        ),
      );
    }
  }

  Future<void> _generatePassword() async {
    final generatedPassword = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const GeneratePassword(shouldReturnPassword: true,)),
    );

    if (generatedPassword != null) {
      setState(() {
        _password.text = generatedPassword;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Editar senha ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                  controller: _title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título';
                    }
                    return null;
                  },
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Título',
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
                  controller: _username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail ou nome de usuário';
                    }
                    return null;
                  },
                  maxLength: 50,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail ou nome de usuário',
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
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                  maxLength: 50,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 17.0,
                      left: 8.0,
                      right: 8.0
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.blueButton,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: () { _generatePassword(); },
                    icon: const Icon(Icons.refresh_outlined),
                    label: const Text(
                      'Gerar senha',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: TextFormField(
                  controller: _passwordOrNameApp,
                  maxLength: 100,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: 'URL do site ou nome do aplicativo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
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
                        onPressed: () {
                          savePassword();
                        },
                        child: Text(
                          'Salvar',
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
                          Icons.check,
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
      ),
    );
  }
}
