import 'package:meta/meta.dart';
import 'package:simple_command/src/async_relay_command.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes asynchronously and returns a value [TOut].
abstract class AsyncTwoWayCommand<TIn, TOut> extends AsyncRelayCommand<TIn> {
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
  Future<TOut?> call([covariant TIn? parameter]) async {
    if (canExecute.value) {
      return execute(parameter);
    }

    return null;
  }

  @protected
  @override
  Future<TOut?> execute([covariant TIn? parameter]);
}

class _AsyncTwoWayCommandImplWithoutParams<TOut> extends AsyncTwoWayCommand<void, TOut> {
  _AsyncTwoWayCommandImplWithoutParams(this._execute);

  final Future<TOut> Function() _execute;

  @protected
  @override
  Future<TOut?> execute([Object? parameter]) async {
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

class _AsyncTwoWayCommandImplWithParams<TIn, TOut> extends AsyncTwoWayCommand<TIn, TOut> {
  _AsyncTwoWayCommandImplWithParams(this._execute);

  final Future<TOut> Function(TIn) _execute;

  @protected
  @override
  Future<TOut?> execute([TIn? parameter]) async {
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
}
