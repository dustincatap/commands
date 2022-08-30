import 'package:commands/src/command.dart';
import 'package:commands/src/utils.dart';

/// A [Command] that executes synchronously.
abstract class RelayCommand extends Command {
  /// Initializes a new instance of [RelayCommand] that does not need any parameter when executing.
  static RelayCommand withoutParam(void Function() execute) {
    return _RelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [RelayCommand] that does not need any parameter when executing.
  static RelayCommand withParam<T>(void Function(T) execute) {
    return _RelayCommandImplWithParams<T>(execute);
  }
}

class _RelayCommandImplWithoutParams extends RelayCommand implements CommandWithoutParam {
  _RelayCommandImplWithoutParams(this._execute);

  final void Function() _execute;

  @override
  void call([Object? parameter]) {
    if (canExecute.value) {
      _execute();
    }
  }
}

class _RelayCommandImplWithParams<T> extends RelayCommand implements CommandWithParam<T> {
  _RelayCommandImplWithParams(this._execute);

  final void Function(T) _execute;

  @override
  void call([T? parameter]) {
    if (canExecute.value) {
      if (parameter != null) {
        _execute(parameter);
      } else if (_execute is void Function(T?)) {
        (_execute as void Function(T?)).call(null);
      } else {
        throw nullParamInNonNullableError<T>();
      }
    }
  }
}
