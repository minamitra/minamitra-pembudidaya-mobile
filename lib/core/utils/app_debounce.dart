import 'dart:async';

class AppDebounce {
  Duration? delay;
  Timer? _timer;

  AppDebounce(this.delay);

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay!, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
