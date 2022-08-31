import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_command/commands.dart';

import 'callable.dart';

void main() {
  group('RelayCommand withoutParam', () {
    late MockCallable mockCallable;

    setUp(() {
      mockCallable = MockCallable();
    });

    RelayCommand createUnit() => RelayCommand.withoutParam(mockCallable);

    test('should execute when called', () async {
      final unit = createUnit();

      unit.call();

      verify(mockCallable.call()).called(1);
    });

    test('should execute when called using itself', () async {
      final unit = createUnit();

      unit();

      verify(mockCallable.call()).called(1);
    });

    test('should not execute if canExecute is false when called', () async {
      final unit = createUnit();

      unit.canExecute.value = false;
      unit.call();

      verifyNever(mockCallable.call());
    });

    test('should not execute if canExecute is false when called using itself', () async {
      final unit = createUnit();

      unit.canExecute.value = false;
      unit();

      verifyNever(mockCallable.call());
    });
  });

  group('RelayCommand withParam', () {
    late MockCallableWithParam mockCallable;

    setUp(() {
      mockCallable = MockCallableWithParam();
    });

    RelayCommand<Object> createUnit() => RelayCommand.withParam(mockCallable);

    test('should execute when called', () async {
      const Object param = Object();
      final unit = createUnit();

      unit.call(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should execute if parameter is null and execute accepts nullable parameter when called', () async {
      Object? param;
      final mockCallable = MockCallableWithNullableParam();
      final unit = RelayCommand.withParam(mockCallable);

      unit.call(param);

      verify(mockCallable.call(null)).called(1);
    });

    test(
      'should throw UnsupportedError if parameter is null and execute does not accept nullable parameter when called',
      () async {
        Object? param;
        final unit = RelayCommand.withParam<Object>((p0) => Future<void>.value());

        expect(() => unit.call(param), throwsUnsupportedError);
      },
    );

    test('should execute when called using itself', () async {
      const Object param = Object();
      final unit = createUnit();

      unit(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should not execute if canExecute is false when called', () async {
      const Object param = Object();
      final unit = createUnit();

      unit.canExecute.value = false;
      unit.call(param);

      verifyNever(mockCallable.call(param));
    });

    test('should not execute if canExecute is false when called using itself', () async {
      const Object param = Object();
      final unit = createUnit();

      unit.canExecute.value = false;
      unit(param);

      verifyNever(mockCallable.call(param));
    });
  });
}
