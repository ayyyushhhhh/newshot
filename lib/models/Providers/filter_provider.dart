import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  String filter = "";
  void changeFilter(String userFilter) {
    if (filter == userFilter) {
      filter = "";
      notifyListeners();
      return;
    }
    filter = userFilter;
    notifyListeners();
  }
}
