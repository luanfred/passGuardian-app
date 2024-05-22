

class PasswordModel {
  String title;
  String url;
  String email;
  String password;
  String favorite;
  int user_id;

  PasswordModel ({
    required this.title,
    required this.url,
    required this.email,
    required this.password,
    this.favorite = 'N',
    required this.user_id
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'email': email,
      'password': password,
      'favorite': favorite,
      'user_id': user_id
    };
  }

  @override
  String toString() {
    return 'PasswordModel{title: $title, url: $url, email: $email, password: $password, favorite: $favorite, user_id: $user_id}';
  }
}