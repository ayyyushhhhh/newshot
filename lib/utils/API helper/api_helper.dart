import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/API%20helper/dio_connectivity_request_retrier.dart';
import 'package:newsapp/utils/API%20helper/retry_interceptor.dart';
import 'package:newsapp/utils/app_constants.dart';

class APIHelper {
  final Dio _dio = Dio();

  void checkConnectivity() {
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  Future<List<NewsModel>> fetchHeadlines() async {
    try {
      Response response = await _dio.get(
        AppConstants.getHeadlines(country: "IN"),
      );

      if (response.statusCode == 200) {
        final data = response.data["articles"] as List;

        List<NewsModel> news = [];

        for (var newsData in data) {
          NewsModel newsModel = NewsModel.fromMap(newsData);
          if (newsModel.author != null &&
              newsModel.content != null &&
              newsModel.description != null &&
              newsModel.title != null &&
              newsModel.urlToImage != null) {
            news.add(newsModel);
          }
        }
        return news;
      }

      return [];
    } on DioError {
      rethrow;
    }
  }

  Future<List<NewsModel>> fetchQueryNews({required String query}) async {
    try {
      Response response = await _dio.get(
        AppConstants.searchNews(keyword: query),
      );

      if (response.statusCode == 200) {
        final data = response.data["articles"] as List;

        List<NewsModel> news = [];

        for (var newsData in data) {
          NewsModel newsModel = NewsModel.fromMap(newsData);
          if (newsModel.author != null &&
              newsModel.content != null &&
              newsModel.description != null &&
              newsModel.title != null &&
              newsModel.urlToImage != null) {
            news.add(newsModel);
          }
        }
        return news;
      }

      return [];
    } on DioError {
      rethrow;
    }
  }
}
