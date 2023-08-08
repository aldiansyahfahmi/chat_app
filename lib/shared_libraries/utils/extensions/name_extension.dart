extension NameExtension on String {
  String getInitials() => isNotEmpty
      ? trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}
