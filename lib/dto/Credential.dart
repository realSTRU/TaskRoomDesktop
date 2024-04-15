class Credential{
  final String username;
  final String password;

  Credential(this.username, this.password);

  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}