import 'package:commands/commands.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'callable.dart';

void main() {
  group('AsyncRelayCommand withoutParam', () {
    late MockAsyncCallable mockCallable;

    setUp(() {
      mockCallable = MockAsyncCallable();
      when(mockCallable.call()).thenAnswer(Future.value);
    });

    AsyncRelayCommand createUnit() => AsyncRelayCommand.withoutParam(mockCallable);

    test('should execute when called', () async {
      final unit = createUnit();

      await unit.call();

      verify(mockCallable.call()).called(1);
    });

    test('should execute when called using itself', () async {
      final unit = createUnit();

      await unit();

      verify(mockCallable.call()).called(1);
    });

    test('should not execute if canExecute is false when called', () async {
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit.call();

      verifyNever(mockCallable.call());
    });

    test('should not execute if canExecute is false when called using itself', () async {
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit();

      verifyNever(mockCallable.call());
    });
  });

  group('AsyncRelayCommand withParam', () {
    late MockAsyncCallableWithParam mockCallable;

    setUp(() {
      mockCallable = MockAsyncCallableWithParam();
    });

    AsyncRelayCommand createUnit() => AsyncRelayCommand.withParam(mockCallable);

    test('should execute when called', () async {
      const Object param = Object();
      final unit = createUnit();

      await unit.call(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should execute if parameter is null and execute accepts nullable parameter when called', () async {
      Object? param;
      final mockCallable = MockAsyncCallableWithNullableParam();
      final unit = AsyncRelayCommand.withParam(mockCallable);

      await unit.call(param);

      verify(mockCallable.call(null)).called(1);
    });

    test(
      'should throw UnsupportedError if parameter is null and execute does not accept nullable parameter when called',
      () async {
        Object? param;
        final unit = AsyncRelayCommand.withParam<Object>((p0) => Future<void>.value());

        expect(() => unit.call(param), throwsUnsupportedError);
      },
    );

    test('should execute when called using itself', () async {
      const Object param = Object();
      final unit = createUnit();

      await unit(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should not execute if canExecute is false when called', () async {
      const Object param = Object();
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit.call(param);

      verifyNever(mockCallable.call(param));
    });

    test('should not execute if canExecute is false when called using itself', () async {
      const Object param = Object();
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit(param);

      verifyNever(mockCallable.call(param));
    });
  });
}
