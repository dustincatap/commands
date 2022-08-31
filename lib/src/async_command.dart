import 'package:flutter/foundation.dart';
import 'package:simple_command/src/command.dart';

/// A [Command] that executes asynchronously.
abstract class AsyncCommand extends Command {
  /// Determines whether the asynchronous execution is finished or not.
  ValueNotifier<bool> isExecuting = ValueNotifier(false);

  /// Executes this command.
  @override
  Future<void> call([Object? parameter]);
}

/// A [Command] that executes asynchronously with a paramter [T].
abstract class AsyncCommandWithParam<T> extends AsyncCommand {
  /// Executes this command.
  @override
  Future<void> call([covariant T? parameter]);
}

/// A [Command] that executes asynchronously without any parameter.
abstract class AsyncCommandWithoutParam extends AsyncCommand {}
