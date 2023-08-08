class UserDataDto {
  final String? username;
  final String? email;
  final String? photo;

  UserDataDto({
    this.username,
    this.email,
    this.photo,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) => UserDataDto(
        username: json['username'],
        email: json['email'],
        photo: json['photo'],
      );
}
