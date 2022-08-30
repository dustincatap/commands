import 'package:commands/src/async_command.dart';
import 'package:commands/src/command.dart';
import 'package:commands/src/utils.dart';

/// A [Command] that executes asynchronously.
abstract class AsyncRelayCommand extends AsyncCommand {
  /// Initializes a new instance of [AsyncRelayCommand] that does not need any parameter when executing.
  static AsyncRelayCommand withoutParam(Future<void> Function() execute) {
    return _AsyncRelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [AsyncRelayCommand] that does not need any parameter when executing.
  static AsyncRelayCommand withParam<T>(Future<void> Function(T) execute) {
    return _AsyncRelayCommandImplWithParams<T>(execute);
  }
}

class _AsyncRelayCommandImplWithoutParams extends AsyncRelayCommand implements AsyncCommandWithoutParam {
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

class _AsyncRelayCommandImplWithParams<T> extends AsyncRelayCommand implements CommandWithParam<T> {
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
