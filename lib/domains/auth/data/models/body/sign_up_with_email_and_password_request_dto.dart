class SignUpWithEmailAndPasswordRequestDto {
  final String email;
  final String username;
  final String photoUrl;
  final String password;

  SignUpWithEmailAndPasswordRequestDto({
    required this.email,
    required this.username,
    required this.photoUrl,
    required this.password,
  });

  Map<String, dynamic> toJson({required String uid}) => {
        'username': username,
        'email': email,
        'uid': uid,
        if (photoUrl.isNotEmpty) 'photo': photoUrl,
      };
}
