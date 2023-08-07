class AuthWithEmailAndPasswordRequestDto {
  final String email;
  final String username;
  final String photo;
  final String password;

  AuthWithEmailAndPasswordRequestDto({
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
