import 'package:commands/src/command.dart';
import 'package:commands/src/utils.dart';

/// A [Command] that executes synchronously and returns a value [TOut].
abstract class TwoWayCommand<TOut> extends Command {
  /// Initializes a new instance of [TwoWayCommand] that does not need any parameter when executing.
  static TwoWayCommand<TOut> withoutParam<TOut>(TOut Function() execute) {
    return _TwoWayCommandImplWithoutParams<TOut>(execute);
  }

  /// Initializes a new instance of [TwoWayCommand] that does not need any parameter when executing.
  static TwoWayCommand<TOut> withParam<TIn, TOut>(TOut Function(TIn) execute) {
    return _TwoWayCommandImplWithParams<TIn, TOut>(execute);
  }

  @override
  TOut? call([Object? parameter]);
}

class _TwoWayCommandImplWithoutParams<TOut> extends TwoWayCommand<TOut> implements CommandWithoutParam {
  _TwoWayCommandImplWithoutParams(this._execute);

  final TOut Function() _execute;

  @override
  TOut? call([Object? parameter]) {
    if (canExecute.value) {
      return _execute();
    }

    return null;
  }
}

class _TwoWayCommandImplWithParams<TIn, TOut> extends TwoWayCommand<TOut> implements CommandWithParam<TIn> {
  _TwoWayCommandImplWithParams(this._execute);

  final TOut Function(TIn) _execute;

  @override
  TOut? call([TIn? parameter]) {
    if (canExecute.value) {
      if (parameter != null) {
        return _execute(parameter);
      } else if (_execute is TOut Function(TIn?)) {
        return (_execute as TOut Function(TIn?)).call(null);
      } else {
        throw nullParamInNonNullableError<TIn>();
      }
    }

    return null;
  }
}
