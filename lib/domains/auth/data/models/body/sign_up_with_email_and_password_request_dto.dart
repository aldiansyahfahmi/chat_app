class SignUpWithEmailAndPasswordRequestDto {
  final String email;
  final String username;
  final String photo;
  final String password;

  SignUpWithEmailAndPasswordRequestDto({
    required this.email,
    required this.username,
    required this.photo,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        if (photo.isNotEmpty) 'photo': photo,
        'email': email,
      };
}
