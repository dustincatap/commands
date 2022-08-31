import 'package:simple_command/src/async_command.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes asynchronously.
abstract class AsyncRelayCommand<T> extends AsyncCommand {
  /// Initializes a new instance of [AsyncRelayCommand] that does not need any parameter when executing.
  static AsyncRelayCommand<void> withoutParam(Future<void> Function() execute) {
    return _AsyncRelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [AsyncRelayCommand] that needs a parameter [T] when executing.
  static AsyncRelayCommand<T> withParam<T>(Future<void> Function(T) execute) {
    return _AsyncRelayCommandImplWithParams<T>(execute);
  }
}

class _AsyncRelayCommandImplWithoutParams extends AsyncRelayCommand<void> implements AsyncCommandWithoutParam {
  _AsyncRelayCommandImplWithoutParams(this._execute);

  final Future<void> Function() _execute;

  @override
  Future<void> call([Object? parameter]) async {
    if (canExecute.value) {
      try {
        isExecuting.value = true;
        await _execute();
      } finally {
        isExecuting.value = false;
      }
    }
  }
}

class _AsyncRelayCommandImplWithParams<T> extends AsyncRelayCommand<T> implements CommandWithParam<T> {
  _AsyncRelayCommandImplWithParams(this._execute);

  final Future<void> Function(T) _execute;

  @override
  Future<void> call([T? parameter]) async {
    if (canExecute.value) {
      try {
        isExecuting.value = true;

        if (parameter != null) {
          await _execute(parameter);
        } else if (_execute is Future<void> Function(T?)) {
          await (_execute as Future<void> Function(T?)).call(null);
        } else {
          throw nullParamInNonNullableError<T>();
        }
      } finally {
        isExecuting.value = false;
      }
    }
  }
}
