

class PasswordModel2 {
  String title;
  String url;
  String email;
  String password;
  String favorite;

  PasswordModel2 ({
    required this.title,
    required this.url,
    required this.email,
    required this.password,
    this.favorite = 'N',
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'email': email,
      'password': password,
      'favorite': favorite,
    };
  }

  @override
  String toString() {
    return 'PasswordModel{title: $title, url: $url, email: $email, password: $password, favorite: $favorite';
  }
}