import 'dart:async';

class Debounce {
  final int milliseconds;
  Timer? _timer;

  Debounce({this.milliseconds = 0});

  run(Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
