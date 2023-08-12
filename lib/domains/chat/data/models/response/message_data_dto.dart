class MessageDataDto {
  final String message;
  final String sender;
  final String time;

  MessageDataDto({
    required this.message,
    required this.sender,
    required this.time,
  });

  factory MessageDataDto.fromJson(Map<String, dynamic> json) => MessageDataDto(
        message: json['message'],
        sender: json['sender'],
        time: json['time'],
      );
}
