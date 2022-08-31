import 'package:simple_command/src/async_command.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes asynchronously and returns a value [TOut].
abstract class AsyncTwoWayCommand<TIn, TOut> extends AsyncCommand {
  /// Initializes a new instance of [AsyncTwoWayCommand] that does not need any parameter when executing.
  ///
  /// Returns a value [TOut].
  static AsyncTwoWayCommand<void, TOut> withoutParam<TOut>(Future<TOut> Function() execute) {
    return _AsyncTwoWayCommandImplWithoutParams<TOut>(execute);
  }

  /// Initializes a new instance of [AsyncTwoWayCommand] that needs a parameter [TIn] when executing.
  ///
  /// Returns a value [TOut].
  static AsyncTwoWayCommand<TIn, TOut> withParam<TIn, TOut>(Future<TOut> Function(TIn) execute) {
    return _AsyncTwoWayCommandImplWithParams<TIn, TOut>(execute);
  }

  @override
  Future<TOut?> call([Object? parameter]);
}

class _AsyncTwoWayCommandImplWithoutParams<TOut> extends AsyncTwoWayCommand<void, TOut>
    implements AsyncCommandWithoutParam {
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

class _AsyncTwoWayCommandImplWithParams<TIn, TOut> extends AsyncTwoWayCommand<TIn, TOut>
    implements CommandWithParam<TIn> {
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
