
import 'dart:convert';
import 'package:app_faculdade/models/password_model.dart';
import 'package:app_faculdade/services/service_parameters.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/password_model2.dart';

class PasswordService extends ServiceParameters {

  savePassword (PasswordModel passwordModel) async {
    final url = '${getUrl()}/passWords';
    final body = json.encode({
      "title": passwordModel.title,
      "url":passwordModel.url,
      "email": passwordModel.email,
      "password": passwordModel.password,
      "user_id": passwordModel.user_id
    });
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    return await http.post(Uri.parse(url), body: body, headers: headers);
  }

  getAllPasswords() async {
    final url = '${getUrl()}/passWords';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<PasswordModel2> passwordsList = [];
      for (var password in json.decode(response.body)) {
        passwordsList.add(PasswordModel2(
          title: password['title'],
          url: password['url'],
          email: password['email'],
          password: password['password'],
        ));
      }
      print("deu certo: $passwordsList");
      return passwordsList;
    } else {
      return 'Erro ao buscar senhas';
    }
  }
}