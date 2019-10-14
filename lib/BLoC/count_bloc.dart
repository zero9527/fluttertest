import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CountBloC {
  int _count;
  StreamController<int> _countController;

  SharedPreferences _local;

  /// BloC 模式
  CountBloC() {
    _countController = StreamController<int>.broadcast();
    init();
  }

  void init() async {
    _local = await SharedPreferences.getInstance();
    _count = _local.get('count') ?? 0;
  }

  Stream<int> get stream => _countController.stream;
  int get count => _count;

  /// _count++
  increment() {
    _countController.sink.add(++_count);
    _local.setInt('count', _count);
  }

  /// _count--
  decrease() {
    _countController.sink.add(--_count);
    _local.setInt('count', _count);
  }

  /// 清空缓存
  clear() {
    _local.clear();
  }

  /// _countController.close()
  dispose() {
    _countController.close();
  }
}

CountBloC countBLoC = CountBloC();
