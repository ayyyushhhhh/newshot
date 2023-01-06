import 'package:flutter/foundation.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/shared_prefrences_handler.dart';

class BookMarkProvider extends ChangeNotifier {
  List<NewsModel> bookMarks = SharedPrefencesHandler.getBookMarks();
  void addBookMark(NewsModel newsModel) {
    bookMarks.add(newsModel);
    SharedPrefencesHandler.saveBookMark(bookMarks);
    notifyListeners();
  }

  void removeBookMark(NewsModel newsModel) {
    bookMarks.remove(newsModel);
    SharedPrefencesHandler.saveBookMark(bookMarks);
    notifyListeners();
  }
}
