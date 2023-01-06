import 'dart:convert';
import 'package:newsapp/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesHandler {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveBookMark(List<NewsModel> newsModel) async {
    List<String> bookMarks = [];
    for (NewsModel news in newsModel) {
      bookMarks.add(jsonEncode(news));
    }
    await preferences?.setStringList("bookmarks", bookMarks);
  }

  static List<NewsModel> getBookMarks() {
    List<NewsModel> bookMarks = [];
    final bookMarksMap = preferences!.getStringList("bookmarks");

    if (bookMarksMap == null) {
      return bookMarks;
    }

    for (String boookmarkmap in bookMarksMap) {
      bookMarks.add(
        NewsModel.fromMap(
            jsonDecode(jsonDecode(boookmarkmap)) as Map<String, dynamic>),
      );
    }
    return bookMarks;
  }
}
