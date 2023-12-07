import 'package:flutter/material.dart';

/// [MaterialSearchBarController] used to provide utility helper method for the [MaterialSearchBar]
class MaterialSearchBarController extends ChangeNotifier {
  /// To check material search bar is visible or not
  bool isSearchBarVisible = false;

  /// Toggle search bar visibility
  /// visible to hidden and hidden to visible
  void toggleSearchBar() {
    notifyListeners();
  }
}
