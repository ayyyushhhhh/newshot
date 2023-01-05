import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  String filter = "";
  void changeFilter(String userFilter) {
    filter = userFilter;
    notifyListeners();
  }
}
