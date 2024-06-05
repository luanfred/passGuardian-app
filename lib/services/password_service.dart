
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
      for (var password in json.decode(utf8.decode(response.bodyBytes))) {
        passwordsList.add(PasswordModel2(
          passwordId: password['password_id'],
          title: password['title'],
          url: password['url'],
          email: password['email'],
          password: password['password'],
        ));
      }
      return passwordsList;
    } else {
      return 'Erro ao buscar senhas';
    }
  }

  getAllPasswordsFavorites() async {
    final url = '${getUrl()}/passWords/favorites';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<PasswordModel2> passwordsList = [];
      for (var password in json.decode(utf8.decode(response.bodyBytes))) {
        passwordsList.add(PasswordModel2(
          passwordId: password['password_id'],
          title: password['title'],
          url: password['url'],
          email: password['email'],
          password: password['password'],
          favorite: password['favorite'],
        ));
      }
      return passwordsList;
    } else {
      return 'Erro ao buscar senhas';
    }
  }

  getPasswordById(int id) async {
    final url = '${getUrl()}/passWords/$id';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var password = json.decode(utf8.decode(response.bodyBytes));
      return PasswordModel2(
        passwordId: password['password_id'],
        title: password['title'],
        url: password['url'],
        email: password['email'],
        password: password['password'],
        favorite: password['favorite'],
      );
    } else {
      return 'Erro ao buscar senha';
    }
  }

  deletePassword(int id) async {
    final url = '${getUrl()}/passWords/$id';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    return await http.delete(Uri.parse(url), headers: headers);
  }

  favoritePassword(PasswordModel2 password) async {
    final url = '${getUrl()}/passWords/${password.passwordId}';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    var favorite = password.favorite == 'S' ? 'N' : 'S';
    password.favorite = favorite;
    var body = json.encode(password.toMap()..update('favorite', (value) => favorite));
    return http.put(Uri.parse(url), body: body, headers: headers);
  }

  updatePassword(PasswordModel2 password) async {
    final url = '${getUrl()}/passWords/${password.passwordId}';
    final prefs = await SharedPreferences.getInstance();
    var emailUserAuth = prefs.getString('username');
    var passwordAuth = prefs.getString('password');
    headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$emailUserAuth:$passwordAuth'))}'
    });
    var body = json.encode(password.toMap());
    return http.put(Uri.parse(url), body: body, headers: headers);
  }

  validatePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    final passwordMaster = prefs.getString('password');
    if (password == passwordMaster) {
      return true;
    } else {
      return false;
    }
  }
}