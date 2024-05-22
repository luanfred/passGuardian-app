import 'dart:convert';
import 'package:app_faculdade/config/app_settings.dart';
import 'package:app_faculdade/models/user_model.dart';
import 'package:app_faculdade/services/service_parameters.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends ServiceParameters {

  authenticate (String username, String password, bool isChecked) async {
    final url = '${getUrl()}/users/login';
    final body = json.encode({
      "username": username,
      "password": password,
    });
    var response = await http.post(Uri.parse(url), body: body, headers: headers);
    print('response.body: ' + response.body);
    if (response.statusCode == 200) {
      await _saveCredentials(username, password, isChecked);
    }
    return response;
  }

  _saveCredentials(String username, String password, bool isChecked) async {
    int userId = await getUserByUsername(username, password);
    await AppSettings().setUserData(username, password, userId, isChecked);
  }

  _getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    var credentialsBase64 = "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    return credentialsBase64;
  }

  saveUser (UserModel user) async {
    final url = '${getUrl()}/users/create';
    final body = json.encode(user.toMap());
    print('url: ' + url);
    print('body: ' + body);
    var response = await http.post(Uri.parse(url), body: body, headers: headers);
    print('response.body: ' + response.body);
    print(response.statusCode.toString());
    return response;
  }

  getUserByUsername (String username, String password) async {
    final url = '${getUrl()}/users/username/$username';
    headers['Authorization'] = "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var response = await http.get(Uri.parse(url), headers: headers);
    var body = json.decode(response.body);
    var userId = body['user_id'];
    return userId;
  }

}