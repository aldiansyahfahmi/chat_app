import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> launch(String url) async {
    await launchUrl(Uri.parse(url));
  }
}
