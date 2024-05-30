import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

class GeneratePassword extends StatefulWidget {
  final bool shouldReturnPassword;
  const GeneratePassword({super.key, this.shouldReturnPassword = false});

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  bool _useLetters = false;
  bool _useDigits = false;
  bool _useSymbols = false;
  double _useLength = 8;
  String _generatedPassword = '';
  late TextEditingController passwordController = TextEditingController();

  void _copyToClipboard() {
    final text = passwordController.text;
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Senha copiada para a área de transferência')),
    );
  }

  void _saveAndReturn() {
    if (widget.shouldReturnPassword) {
      Navigator.pop(context, _generatedPassword);
    }
  }

  void _generatePassword() {
    String charset = '';
    if (_useLetters) charset += 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (_useDigits) charset += '0123456789';
    if (_useSymbols) charset += '!@&%*';

    int length = int.parse(_useLength.round().toString());

    if (charset.isNotEmpty) {
      var random = Random();
      var password = List.generate(length, (_) => charset[random.nextInt(charset.length)]);
      _generatedPassword = password.join();
    } else {
      _generatedPassword = 'Selecione pelo menos uma opção';
    }

    print('Generated password: $_generatedPassword');

    setState(() {
      passwordController.text = _generatedPassword;
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              readOnly: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Usar Letras (A-Z)'),
                Switch(
                    value: _useLetters,
                    onChanged: (value) {
                      setState(() {
                        _useLetters = value;
                        _generatePassword();
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Usar Dígitos (0-9)'),
                Switch(
                    value: _useDigits,
                    onChanged: (value) {
                      setState(() {
                        _useDigits = value;
                        _generatePassword();
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Usar Símbolos (!@&%*)'),
                Switch(
                    value: _useSymbols,
                    onChanged: (value) {
                      setState(() {
                        _useSymbols = value;
                        _generatePassword();
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tamanho: ${_useLength.round()}'),
                Slider(
                  value: _useLength,
                  min: 8,
                  max: 16,
                  label: _useLength.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _useLength = value;
                      _generatePassword();
                    });
                  }
                ),
              ],
            ),
            SizedBox(height: 20),
           Padding(
             padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Column(
                   children: [
                     ElevatedButton(
                         onPressed: () {
                           _copyToClipboard();
                         },
                         child: const Icon(Icons.copy_outlined, color: Colors.white,),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: ThemeColors.blueButton,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(50),
                           ),
                           padding: const EdgeInsets.all(20),
                         )
                     ),
                     const Text('Copiar'),
                   ],
                 ),
                 Column(
                   children: [
                     ElevatedButton(
                         onPressed: _generatePassword,
                         child: const Icon(Icons.refresh_outlined, color: Colors.white,),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: ThemeColors.blueButton,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(50),
                           ),
                           padding: const EdgeInsets.all(20),
                         )
                     ),
                     const Text('Gerar Senha'),
                   ],
                 ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _saveAndReturn();
                          },
                          child: const Icon(Icons.save_outlined, color: Colors.white,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.blueButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(20),
                          )
                      ),
                      const Text('Salvar'),
                    ],
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
