class MaterialSearchBarController {
  late Function _callback;

  register(Function callback) {
    _callback = callback;
  }

  void toggleSearchBar() {
    _callback.call();
  }
}
