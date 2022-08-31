import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_command/commands.dart';

import 'callable.dart';

void main() {
  group('AsyncTwoWayCommand withoutParam', () {
    late MockAsyncCallableWithResult mockCallable;

    setUp(() {
      mockCallable = MockAsyncCallableWithResult();
    });

    AsyncTwoWayCommand<void, Object> createUnit() => AsyncTwoWayCommand.withoutParam(mockCallable);

    test('should execute when called', () async {
      when(mockCallable.call()).thenAnswer(Future.value);
      final unit = createUnit();

      await unit.call();

      verify(mockCallable.call()).called(1);
    });

    test('should return expected result when called', () async {
      const expectedResult = Object();
      when(mockCallable.call()).thenAnswer((_) async => expectedResult);
      final unit = createUnit();

      final actualResult = await unit.call();

      expect(actualResult, expectedResult);
    });

    test('should execute when called using itself', () async {
      when(mockCallable.call()).thenAnswer(Future.value);
      final unit = createUnit();

      await unit();

      verify(mockCallable.call()).called(1);
    });

    test('should return expected result when called using itself', () async {
      const expectedResult = Object();
      when(mockCallable.call()).thenAnswer((_) async => expectedResult);
      final unit = createUnit();

      final actualResult = await unit();

      expect(actualResult, expectedResult);
    });

    test('should not execute if canExecute is false when called', () async {
      when(mockCallable.call()).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit.call();

      verifyNever(mockCallable.call());
    });

    test('should return null if canExecute is false when called', () async {
      when(mockCallable.call()).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = await unit.call();

      expect(actualResult, isNull);
    });

    test('should return null if canExecute is false when called using itself', () async {
      when(mockCallable.call()).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = await unit();

      expect(actualResult, isNull);
    });
  });

  group('AsyncTwoWayCommand withParam', () {
    late MockAsyncCallableWithParamAndResult mockCallable;

    setUp(() {
      mockCallable = MockAsyncCallableWithParamAndResult();
    });

    AsyncTwoWayCommand<Object, Object> createUnit() => AsyncTwoWayCommand.withParam(mockCallable);

    test('should execute when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = createUnit();

      await unit.call(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should return expected result when called', () async {
      const expectedResult = Object();
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer((_) async => expectedResult);
      final unit = createUnit();

      final actualResult = await unit.call(param);

      expect(actualResult, expectedResult);
    });

    test('should execute when called using itself', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = createUnit();

      await unit(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should return expected result when called using itself', () async {
      const expectedResult = Object();
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer((_) async => expectedResult);
      final unit = createUnit();

      final actualResult = await unit(param);

      expect(actualResult, expectedResult);
    });

    test('should execute if parameter is null and execute accepts nullable parameter when called', () async {
      Object? param;
      final mockCallable = MockAsyncCallableWithNullableParamAndResult();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = AsyncTwoWayCommand.withParam(mockCallable);

      await unit.call(param);

      verify(mockCallable.call(null)).called(1);
    });

    test(
      'should return expected result if parameter is null and execute accepts nullable parameter when called',
      () async {
        Object? param;
        const expectedResult = Object();
        final mockCallable = MockAsyncCallableWithNullableParamAndResult();
        when(mockCallable.call(param)).thenAnswer((_) async => expectedResult);
        final unit = AsyncTwoWayCommand.withParam(mockCallable);

        final actualResult = await unit.call(param);

        expect(actualResult, expectedResult);
      },
    );

    test(
      'should throw UnsupportedError if parameter is null and execute does not accept nullable parameter when called',
      () async {
        Object? param;
        final unit = AsyncTwoWayCommand.withParam<Object, Object>((p0) async => Object());

        expect(() => unit.call(param), throwsUnsupportedError);
      },
    );

    test('should not execute if canExecute is false when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      await unit.call(param);

      verifyNever(mockCallable.call(param));
    });

    test('should return null if canExecute is false when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = await unit.call(param);

      expect(actualResult, isNull);
    });

    test('should return null if canExecute is false when called using itself', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenAnswer(Future.value);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = await unit(param);

      expect(actualResult, isNull);
    });
  });
}
