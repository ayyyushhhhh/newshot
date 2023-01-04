class AppConstants {
  static const String _apiKey = "255c7aa01c8341c0aa08eb7076540a38";
  static String searchNews({required String keyword}) {
    return "https://newsapi.org/v2/everything?q=$keyword&apiKey=$_apiKey";
  }

  static String getHeadlines({required String country}) {
    return "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$_apiKey";
  }
}
