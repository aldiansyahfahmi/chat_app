class AuthWithEmailAndPasswordRequestDto {
  final String email;
  final String password;

  AuthWithEmailAndPasswordRequestDto(
      {required this.email, required this.password});
}
