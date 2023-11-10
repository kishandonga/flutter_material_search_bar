import 'package:flutter/material.dart';

class MaterialSearchBarController extends ChangeNotifier {
  bool isSearchBarVisible = false;

  void toggleSearchBar() {
    notifyListeners();
  }
}
