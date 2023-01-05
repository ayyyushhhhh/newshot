import 'package:flutter/material.dart';

class QueryProvider with ChangeNotifier {
  String query = "";
  void sendQuery(String userQuery) {
    query = userQuery;
    notifyListeners();
  }
}
