import 'package:flutter/foundation.dart';
import 'package:simple_command/src/command.dart';
import 'package:simple_command/src/utils.dart';

/// A [Command] that executes synchronously.
abstract class RelayCommand<TIn> implements Command {
  /// Determines whether execution is allowed.
  final ValueNotifier<bool> canExecute = ValueNotifier(true);

  /// Initializes a new instance of [RelayCommand] that does not need any parameter when executing.
  static RelayCommand<void> withoutParam(void Function() execute) {
    return _RelayCommandImplWithoutParams(execute);
  }

  /// Initializes a new instance of [RelayCommand] that needs a parameter [TIn] when executing.
  static RelayCommand<TIn> withParam<TIn>(void Function(TIn) execute) {
    return _RelayCommandImplWithParams<TIn>(execute);
  }

  @override
  void call([Object? parameter]) {
    if (canExecute.value) {
      execute(parameter);
    }
  }

  /// Internally executes this command.
  @protected
  void execute([Object? parameter]);
}

class _RelayCommandImplWithoutParams extends RelayCommand<void> {
  _RelayCommandImplWithoutParams(this._execute);

  final void Function() _execute;

  @protected
  @override
  void execute([Object? parameter]) => _execute();
}

class _RelayCommandImplWithParams<TIn> extends RelayCommand<TIn> {
  _RelayCommandImplWithParams(this._execute);

  final void Function(TIn) _execute;

  @protected
  @override
  void execute([covariant TIn? parameter]) {
    if (parameter != null) {
      _execute(parameter);
    } else if (_execute is void Function(TIn?)) {
      (_execute as void Function(TIn?)).call(null);
    } else {
      throw nullParamInNonNullableError<TIn>();
    }
  }
}
