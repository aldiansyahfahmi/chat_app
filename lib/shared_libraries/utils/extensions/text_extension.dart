extension TextExtension on String {
  String capitalize() {
    return this[0].toString().toUpperCase() + substring(1).toLowerCase();
  }
}
