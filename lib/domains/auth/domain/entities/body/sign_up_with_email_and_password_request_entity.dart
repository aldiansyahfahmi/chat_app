class SignUpWithEmailAndPasswordRequestEntity {
  final String email;
  final String username;
  final String photo;
  final String password;

  SignUpWithEmailAndPasswordRequestEntity({
    required this.email,
    required this.username,
    required this.photo,
    required this.password,
  });
}
