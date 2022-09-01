import 'package:simple_command/src/async_relay_command.dart';
import 'package:simple_command/src/async_two_way_command.dart';
import 'package:simple_command/src/relay_command.dart';
import 'package:simple_command/src/two_way_command.dart';

/// Base class of all command objects.
///
/// See:
/// - [RelayCommand] for synchronous executions.
/// - [AsyncRelayCommand] for asynchronous executions.
/// - [TwoWayCommand] for synchronous executions that returns a value.
/// - [AsyncTwoWayCommand] for asynchronous executions that returns a value.
abstract class Command {
  /// Executes this command.
  ///
  /// - [parameter] is an optional value. It will depend on the type of command whether this will be handled or not.
  void call([Object? parameter]);
}
