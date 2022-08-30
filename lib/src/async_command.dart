import 'package:commands/src/command.dart';
import 'package:flutter/foundation.dart';

/// A [Command] that executes asynchronously.
abstract class AsyncCommand extends Command {
  /// Determines whether the asynchronous execution is finished or not.
  ValueNotifier<bool> isExecuting = ValueNotifier(false);

  /// Executes this command.
  @override
  Future<void> call([Object? parameter]);
}

abstract class AsyncCommandWithParam<T> extends AsyncCommand {
  /// Executes this command.
  @override
  Future<void> call([covariant T? parameter]);
}

abstract class AsyncCommandWithoutParam extends AsyncCommand {}
