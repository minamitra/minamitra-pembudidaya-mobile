class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, String> toMap() {
    return {
      'email': username,
      'password': password,
    };
  }
}
