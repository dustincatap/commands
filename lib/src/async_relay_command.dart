import 'package:flutter/foundation.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/relay_command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes asynchronously.
abstract class AsyncRelayCommand<TIn> extends RelayCommand<TIn> {
  /// Determines whether the asynchronous execution is finished or not.
  ValueNotifier<bool> isExecuting = ValueNotifier(false);

  /// Initializes a new instance of [AsyncRelayCommand] that does not need any parameter when executing.
  static AsyncRelayCommand<void> withoutParam(Future<void> Function() execute) {
    return _AsyncRelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [AsyncRelayCommand] that needs a parameter [TIn] when executing.
  static AsyncRelayCommand<TIn> withParam<TIn>(Future<void> Function(TIn) execute) {
    return _AsyncRelayCommandImplWithParams<TIn>(execute);
  }

  @override
  Future<void> call([Object? parameter]) async {
    if (canExecute.value) {
      try {
        isExecuting.value = true;
        await execute(parameter);
      } finally {
        isExecuting.value = false;
      }
    }
  }

  @protected
  @override
  Future<void> execute([Object? parameter]);
}

class _AsyncRelayCommandImplWithoutParams extends AsyncRelayCommand<void> {
  _AsyncRelayCommandImplWithoutParams(this._execute);

  final Future<void> Function() _execute;

  @protected
  @override
  Future<void> execute([Object? parameter]) => _execute();
}

class _AsyncRelayCommandImplWithParams<TIn> extends AsyncRelayCommand<TIn> {
  _AsyncRelayCommandImplWithParams(this._execute);

  final Future<void> Function(TIn) _execute;

  @protected
  @override
  Future<void> execute([covariant TIn? parameter]) async {
    if (parameter != null) {
      await _execute(parameter);
    } else if (_execute is Future<void> Function(TIn?)) {
      await (_execute as Future<void> Function(TIn?)).call(null);
    } else {
      throw nullParamInNonNullableError<TIn>();
    }
  }
}
