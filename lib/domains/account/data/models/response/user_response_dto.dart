class UserResponseDto {
  final String? username;
  final String? email;
  final String? photo;

  UserResponseDto({
    this.username,
    this.email,
    this.photo,
  });

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      UserResponseDto(
        username: json['username'],
        email: json['email'],
        photo: json['photo'],
      );
}
