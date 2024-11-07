import 'dart:async';

class AppDebounce {
  Duration? delay;
  Timer? _timer;

  AppDebounce(this.delay);

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay!, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
