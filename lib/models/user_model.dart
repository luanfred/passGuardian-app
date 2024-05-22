
class UserModel {
  String cpf;
  String name;
  String username;
  String password;

  UserModel({
    required this.cpf,
    required this.name,
    required this.username,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'name': name,
      'username': username,
      'password': password
    };
  }

  @override
  String toString() {
    return 'UserModel{cpf: $cpf, name: $name, username: $username, password: $password}';
  }
}