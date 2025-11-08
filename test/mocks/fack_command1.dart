import 'package:flutter/foundation.dart';
import 'package:store/utils/Command.dart';
import 'package:store/utils/result.dart';

class FakeCommand1<T, P> extends ChangeNotifier implements Command1<T, P> {
  bool _running;
  bool _error;
  bool _completed;
  Result<T>? _result;


  FakeCommand1({
    bool isRunning = false,
    bool hasError = false,
    bool isCompleted = false,
    Result<T>? result,
  })  : _running = isRunning,
        _error = hasError,
        _completed = isCompleted,
        _result = result;

  @override
  bool get running => _running;

  @override
  bool get error => _error;

  @override
  bool get completed => _completed;

  @override
  Result<T>? get result => _result ?? Result.ok(null as T);


  @override
  Future<void> execute(P param) async {
    _running = true;
    _error = false;
    _completed = false;
    notifyListeners();

    await Future.delayed(Duration.zero);

    _running = false;
    _completed = true;
    _result ??= Result.ok(null as T);
    notifyListeners();
  }

  @override
  void clearResult() {
    _result = null;
    _completed = false;
    _error = false;
    notifyListeners();
  }
}
