class AuthWithEmailAndPasswordRequestEntity {
  final String email;
  final String username;
  final String photo;
  final String password;

  AuthWithEmailAndPasswordRequestEntity({
    required this.email,
    required this.username,
    required this.photo,
    required this.password,
  });
}
