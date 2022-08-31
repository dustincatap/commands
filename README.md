### Description

A simple Flutter package for wrapping method executions in a Command object.

#### Synchronous Commands

##### RelayCommand

These commands wraps a synchronous method and executes it.

```dart
import 'package:simple_command/commands.dart';

final RelayCommand<void> loginCommand = RelayCommand.withoutParam(_onLogin);

void _onLogin() { }

// Call it by using `call`
loginCommand.call();

// Or by itself
loginCommand();
```

You can also pass a parameter:

```dart
final RelayCommand<String> loginCommand = RelayCommand.withParam(_onLogin);

void _onLogin(String a) { }

// Call it by using `call`
loginCommand.call("someParam");

// Or by itself
loginCommand("someParam");
```

##### TwoWayCommand

If you want your command to return a value, use this.

```dart
final TwoWayCommand<void, String> loginCommand = TwoWayCommand.withoutParam(_onLogin);

String _onLogin() {
  return 'some result';
}

// Call it
final result = loginCommand();
```

You can also pass a parameter:

```dart
final TwoWayCommand<Object, String> loginCommand = TwoWayCommand.withParam(_onLogin);

String _onLogin(Object param) {
  return param.toString();
}

// Call it
final result = loginCommand(someParam);
```

#### Asynchronous Commands

##### AsyncRelayCommand

These commands wraps an asynchronous method and executes it.

```dart
import 'package:simple_command/commands.dart';

final AsyncRelayCommand<void> loginCommand = AsyncRelayCommand.withoutParam(_onLogin);

Future<void> _onLogin() async { }

// Call it by using `call`
await loginCommand.call();

// Or by itself
await loginCommand();
```

You can also pass a parameter:

```dart
final AsyncRelayCommand<String> loginCommand = AsyncRelayCommand.withParam(_onLogin);

Future<void> _onLogin(String param) async { }

// Call it by using `call`
await loginCommand.call(someParam);

// Or by itself
await loginCommand(someParam);
```

##### AsyncTwoWayCommand

If you want your command to return a value, use this.

```dart
final AsyncTwoWayCommand<void, String> loginCommand = AsyncTwoWayCommand.withoutParam(_onLogin);

Future<String> _onLogin() async {
  return 'some result';
}

// Call it
final result = await loginCommand();
```

You can also pass a parameter:

```dart
final AsyncTwoWayCommand<String, String> loginCommand = AsyncTwoWayCommand.withParam(_onLogin);

Future<String> _onLogin(String param) async {
  return 'some result';
}

// Call it
final result = await loginCommand(someParam);
```

#### Other features

##### Disable a command

You can disable the execution of a command by setting `canExecute`'s value:

```dart
final RelayCommand<void> loginCommand = RelayCommand.withoutParam(...);

loginCommand.canExecute.value = false;
```

##### Checking if an async command is finished

You can do this by checking `isExecuting`'s value. This is useful if you want your UI to show a loading indicator while the command is executing:

```dart
final AsyncRelayCommand<void> loginCommand = AsyncRelayCommand.withParam(...);

ElevatedButton(
  onPressed: loginCommand,
  child: ValueListenableBuilder<bool>(
    valueListenable: loginCommand.isExecuting,
    builder: (context, isExecuting, _) {
      if (isExecuting) {
        return SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        );
      }

      return const Text('Login');
    },
  ),
);
```

#### Important notes

##### Passing null parameter to a non-nullable accepting command

```dart
final RelayCommand<String> command = RelayCommand.withParam(_onExecute);

// Bad
void _onExecute(String param) { }

// This will throw an error
command.call(null);

// Good
void _onExecute(String? param) { }
```

##### Disabling an async command that returns a value

When you set `isExecuting` to false, calling an async command that returns a value will return `null`.