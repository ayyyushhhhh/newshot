import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String _apiKey = dotenv.env['API_KEY']!;
  static String searchNews({required String keyword}) {
    return "https://newsapi.org/v2/everything?q=$keyword&apiKey=$_apiKey";
  }

  static String getHeadlines({required String country}) {
    return "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey";
  }
}
