import 'package:flutter/foundation.dart';
import 'package:simple_command/src/async_command.dart';
import 'package:simple_command/src/async_relay_command.dart';
import 'package:simple_command/src/async_two_way_command.dart';
import 'package:simple_command/src/relay_command.dart';
import 'package:simple_command/src/two_way_command.dart';

/// Base class of all command objects.
///
/// See:
/// - [RelayCommand] for synchronous executions.
/// - [AsyncCommand] and [AsyncRelayCommand] for asynchronous executions.
/// - [TwoWayCommand] for synchronous executions that returns a value.
/// - [AsyncTwoWayCommand] for asynchronous executions that returns a value.
abstract class Command {
  /// Determines whether execution is allowed.
  final ValueNotifier<bool> canExecute = ValueNotifier(true);

  /// Executes this command.
  void call([Object? parameter]);
}

abstract class CommandWithParam<T> extends Command {
  /// Executes this command.
  @override
  void call([covariant T? parameter]);
}

abstract class CommandWithoutParam extends Command {}
