import 'package:meta/meta.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes synchronously.
abstract class RelayCommand<T> extends Command {
  /// Initializes a new instance of [RelayCommand] that does not need any parameter when executing.
  static RelayCommand<void> withoutParam(void Function() execute) {
    return _RelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [RelayCommand] that needs a parameter [T] when executing.
  static RelayCommand<T> withParam<T>(void Function(T) execute) {
    return _RelayCommandImplWithParams<T>(execute);
  }
}

class _RelayCommandImplWithoutParams extends Command implements RelayCommand<void> {
  _RelayCommandImplWithoutParams(this._execute);

  final void Function() _execute;

  @protected
  @override
  void execute() => _execute();
}

class _RelayCommandImplWithParams<T> extends CommandWithParam<T> implements RelayCommand<T> {
  _RelayCommandImplWithParams(this._execute);

  final void Function(T) _execute;

  @protected
  @override
  void execute([T? parameter]) {
    if (parameter != null) {
      _execute(parameter);
    } else if (_execute is void Function(T?)) {
      (_execute as void Function(T?)).call(null);
    } else {
      throw nullParamInNonNullableError<T>();
    }
  }
}
