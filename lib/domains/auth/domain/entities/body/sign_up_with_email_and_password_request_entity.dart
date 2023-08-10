class SignUpWithEmailAndPasswordRequestEntity {
  final String email;
  final String username;
  final String photoUrl;
  final String password;

  SignUpWithEmailAndPasswordRequestEntity({
    required this.email,
    required this.username,
    required this.photoUrl,
    required this.password,
  });
}
