import 'package:flutter/foundation.dart';
import 'package:newsapp/models/news_model.dart';

class BookMarkProvider extends ChangeNotifier {
  List<NewsModel> bookMarks = [];
  void addBookMark(NewsModel newsModel) {
    bookMarks.add(newsModel);
    notifyListeners();
  }

  void removeBookMark(NewsModel newsModel) {
    bookMarks.remove(newsModel);
    notifyListeners();
  }
}
