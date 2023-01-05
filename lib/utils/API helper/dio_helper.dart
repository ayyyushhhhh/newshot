import 'package:dio/dio.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/app_constants.dart';

class APIHelper {
  final Dio _dio = Dio();
  Future<List<NewsModel>> fetchHeadlines() async {
    try {
      Response response = await _dio.get(
        AppConstants.getHeadlines(country: "IN"),
      );
      if (response.statusCode == 200) {
        final data = response.data["articles"] as List;

        List<NewsModel> news = [];

        for (var newsData in data) {
          news.add(NewsModel.fromMap(newsData));
        }
        return news;
      }

      throw [];
    } on DioError {
      rethrow;
    }
  }
}
