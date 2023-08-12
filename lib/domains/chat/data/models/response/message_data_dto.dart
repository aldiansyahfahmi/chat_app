class MessageDataDto {
  final String message;
  final String sender;

  MessageDataDto({
    required this.message,
    required this.sender,
  });

  factory MessageDataDto.fromJson(Map<String, dynamic> json) => MessageDataDto(
        message: json['message'],
        sender: json['sender'],
      );
}
