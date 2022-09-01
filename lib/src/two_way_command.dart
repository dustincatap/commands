import 'package:meta/meta.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/relay_command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes synchronously and returns a value [TOut].
abstract class TwoWayCommand<TIn, TOut> extends RelayCommand<TIn> {
  /// Initializes a new instance of [TwoWayCommand] that does not need any parameter when executing.
  ///
  /// Returns a value [TOut].
  static TwoWayCommand<void, TOut> withoutParam<TOut>(TOut Function() execute) {
    return _TwoWayCommandImplWithoutParams<void, TOut>(execute);
  }

  /// Initializes a new instance of [TwoWayCommand] that needs a parameter [TIn] when executing.
  ///
  /// Returns a value [TOut].
  static TwoWayCommand<TIn, TOut> withParam<TIn, TOut>(TOut Function(TIn) execute) {
    return _TwoWayCommandImplWithParams<TIn, TOut>(execute);
  }

  @override
  TOut? call([covariant TIn? parameter]) {
    if (canExecute.value) {
      return execute(parameter);
    }

    return null;
  }

  @protected
  @override
  TOut? execute([covariant TIn? parameter]);
}

class _TwoWayCommandImplWithoutParams<TIn, TOut> extends TwoWayCommand<TIn, TOut> {
  _TwoWayCommandImplWithoutParams(this._execute);

  final TOut Function() _execute;

  @protected
  @override
  TOut? execute([TIn? parameter]) => _execute();
}

class _TwoWayCommandImplWithParams<TIn, TOut> extends TwoWayCommand<TIn, TOut> {
  _TwoWayCommandImplWithParams(this._execute);

  final TOut Function(TIn) _execute;

  @protected
  @override
  TOut? execute([TIn? parameter]) {
    if (parameter != null) {
      return _execute(parameter);
    } else if (_execute is TOut Function(TIn?)) {
      return (_execute as TOut Function(TIn?)).call(null);
    } else {
      throw nullParamInNonNullableError<TIn>();
    }
  }
}
