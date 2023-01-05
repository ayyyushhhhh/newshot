import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openLinks({required String url}) {
    return _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
