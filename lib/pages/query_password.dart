import 'package:app_faculdade/models/password_model2.dart';
import 'package:flutter/material.dart';

import '../services/password_service.dart';
import '../theme/app_colors.dart';

class QueryPassword extends StatefulWidget {
  const QueryPassword({super.key, required this.passwordId});
  final int passwordId;

  @override
  State<QueryPassword> createState() => _QueryPasswordState();
}

class _QueryPasswordState extends State<QueryPassword> {
  bool _obscureText = true;
  late bool _isFavorite = false;
  bool _isLoading = true;
  late PasswordModel2 password;
  String _title = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  getInfoPassword() async {
    password = await PasswordService().getPasswordById(widget.passwordId);
    _emailController.text = password.email;
    _passwordController.text = password.password;
    _urlController.text = password.url;
    setState(() {
      _title = password.title;
      if (password.favorite == 'S') {
        _isFavorite = true;
      } else {
        _isFavorite = false;
      }
      _isLoading = false;
    });
  }

  favoritePassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await PasswordService().favoritePassword(password);
    Navigator.pop(context);
    if (password.favorite == 'S') {
      setState(() {
        _isFavorite = true;
      });
    } else {
      setState(() {
        _isFavorite = false;
      });
    }
  }

  deletePassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await PasswordService().deletePassword(widget.passwordId);
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: true);
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Você tem certeza que deseja excluir esta senha?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deletePassword();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
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
          'Consultar senha',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeColors.blueText,
            fontSize: 24,
          ),
        ),
        backgroundColor: ThemeColors.backgroundColor,
      ),
      body:
      _isLoading ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 35.0,
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: Text(
                  _title,
                  style: const TextStyle(
                    color: ThemeColors.blueText,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 100,
                      child: OutlinedButton(
                        onPressed: () {
                          favoritePassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ThemeColors.blueText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: _isFavorite ? Colors.red : ThemeColors.blueText,
                            ),
                            const SizedBox(height: 8),
                            const Text('Favorito'),
                          ],
                        )
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      height: 100,
                      child: OutlinedButton(
                          onPressed: () async {
                            final updatedPassword = await Navigator.pushNamed(
                              context,
                              '/editPassword',
                              arguments: password,
                            );

                            if (updatedPassword != null && updatedPassword is PasswordModel2) {
                              setState(() {
                                password = updatedPassword;
                                _title = password.title;
                                _emailController.text = password.email;
                                _passwordController.text = password.password;
                                _urlController.text = password.url;
                                _isFavorite = password.favorite == 'S';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: ThemeColors.blueText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: ThemeColors.blueText,
                              ),
                              SizedBox(height: 8),
                              Text('Editar'),
                            ],
                          )
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      height: 100,
                      child: OutlinedButton(
                          onPressed: () {
                            showConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: ThemeColors.blueText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: ThemeColors.blueText,
                              ),
                              SizedBox(height: 8),
                              Text('Apagar'),
                            ],
                          )
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 17.0,
                    left: 8.0,
                    right: 8.0
                ),
                child: TextFormField(
                  controller: _emailController,
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
                  controller: _passwordController,
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
                child: TextFormField(
                  controller: _urlController,
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
     ],
    ),
    ),
    );
  }
}
