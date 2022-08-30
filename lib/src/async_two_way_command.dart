import 'package:commands/src/async_command.dart';
import 'package:commands/src/command.dart';
import 'package:commands/src/utils.dart';

/// A [Command] that executes asynchronously and returns a value [TOut].
abstract class AsyncTwoWayCommand<TOut> extends AsyncCommand {
  /// Initializes a new instance of [AsyncTwoWayCommand] that does not need any parameter when executing.
  static AsyncTwoWayCommand<TOut> withoutParam<TOut>(Future<TOut> Function() execute) {
    return _AsyncTwoWayCommandImplWithoutParams<TOut>(execute);
  }

  /// Initializes a new instance of [AsyncTwoWayCommand] that does not need any parameter when executing.
  static AsyncTwoWayCommand<TOut> withParam<TIn, TOut>(Future<TOut> Function(TIn) execute) {
    return _AsyncTwoWayCommandImplWithParams<TIn, TOut>(execute);
  }

  @override
  Future<TOut?> call([Object? parameter]);
}

class _AsyncTwoWayCommandImplWithoutParams<TOut> extends AsyncTwoWayCommand<TOut> implements AsyncCommandWithoutParam {
  _AsyncTwoWayCommandImplWithoutParams(this._execute);

  final Future<TOut> Function() _execute;

  @override
  Future<TOut?> call([Object? parameter]) async {
    if (canExecute.value) {
      try {
        isExecuting.value = true;

        return _execute();
      } finally {
        isExecuting.value = false;
      }
    }

    return null;
  }
}

class _AsyncTwoWayCommandImplWithParams<TIn, TOut> extends AsyncTwoWayCommand<TOut> implements CommandWithParam<TIn> {
  _AsyncTwoWayCommandImplWithParams(this._execute);

  final Future<TOut> Function(TIn) _execute;

  @override
  Future<TOut?> call([TIn? parameter]) async {
    if (canExecute.value) {
      try {
        isExecuting.value = true;

        if (parameter != null) {
          return await _execute(parameter);
        } else if (_execute is Future<TOut> Function(TIn?)) {
          return await (_execute as Future<TOut> Function(TIn?)).call(null);
        } else {
          throw nullParamInNonNullableError<TIn>();
        }
      } finally {
        isExecuting.value = false;
      }
    }

    return null;
  }
}
