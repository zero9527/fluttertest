import 'dart:async';

class CountBloC {
  int _count;
  StreamController<int> _countController;

  /// BloC 模式
  CountBloC() {
    _count = 0;
    _countController = StreamController<int>.broadcast();
  }

  Stream<int> get stream => _countController.stream;
  int get count => _count;

  /// _count++
  increment() {
    _countController.sink.add(++_count);
  }

  /// _count--
  decrease() {
    _countController.sink.add(--_count);
  }

  /// _countController.close()
  dispose() {
    _countController.close();
  }
}

CountBloC countBLoC = CountBloC();
