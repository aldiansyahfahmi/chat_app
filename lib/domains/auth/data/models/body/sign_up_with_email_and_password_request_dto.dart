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

  Map<String, dynamic> toJson({required String uid}) => {
        'username': username,
        'email': email,
        'uid': uid,
        if (photo.isNotEmpty) 'photo': photo,
        'chat': [],
      };
}
