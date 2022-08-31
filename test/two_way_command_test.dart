import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_command/commands.dart';

import 'callable.dart';

void main() {
  group('TwoWayCommand withoutParam', () {
    late MockCallableWithResult mockCallable;

    setUp(() {
      mockCallable = MockCallableWithResult();
    });

    TwoWayCommand<void, Object> createUnit() => TwoWayCommand.withoutParam(mockCallable);

    test('should execute when called', () async {
      when(mockCallable.call()).thenReturn(anything);
      final unit = createUnit();

      unit.call();

      verify(mockCallable.call()).called(1);
    });

    test('should return expected result when called', () async {
      const expectedResult = Object();
      when(mockCallable.call()).thenReturn(expectedResult);
      final unit = createUnit();

      final actualResult = unit.call();

      expect(actualResult, expectedResult);
    });

    test('should execute when called using itself', () async {
      when(mockCallable.call()).thenReturn(anything);
      final unit = createUnit();

      unit();

      verify(mockCallable.call()).called(1);
    });

    test('should return expected result when called using itself', () async {
      const expectedResult = Object();
      when(mockCallable.call()).thenReturn(expectedResult);
      final unit = createUnit();

      final actualResult = unit();

      expect(actualResult, expectedResult);
    });

    test('should not execute if canExecute is false when called', () async {
      when(mockCallable.call()).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      unit.call();

      verifyNever(mockCallable.call());
    });

    test('should return null if canExecute is false when called', () async {
      when(mockCallable.call()).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = unit.call();

      expect(actualResult, isNull);
    });

    test('should return null if canExecute is false when called using itself', () async {
      when(mockCallable.call()).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = unit();

      expect(actualResult, isNull);
    });
  });

  group('TwoWayCommand withParam', () {
    late MockCallableWithParamAndResult mockCallable;

    setUp(() {
      mockCallable = MockCallableWithParamAndResult();
    });

    TwoWayCommand<void, Object> createUnit() => TwoWayCommand.withParam(mockCallable);

    test('should execute when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = createUnit();

      unit.call(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should return expected result when called', () async {
      const expectedResult = Object();
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(expectedResult);
      final unit = createUnit();

      final actualResult = unit.call(param);

      expect(actualResult, expectedResult);
    });

    test('should execute when called using itself', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = createUnit();

      unit(param);

      verify(mockCallable.call(param)).called(1);
    });

    test('should return expected result when called using itself', () async {
      const expectedResult = Object();
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(expectedResult);
      final unit = createUnit();

      final actualResult = unit(param);

      expect(actualResult, expectedResult);
    });

    test('should execute if parameter is null and execute accepts nullable parameter when called', () async {
      Object? param;
      final mockCallable = MockCallableWithNullableParamAndResult();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = TwoWayCommand.withParam(mockCallable);

      unit.call(param);

      verify(mockCallable.call(null)).called(1);
    });

    test(
      'should return expected result if parameter is null and execute accepts nullable parameter when called',
      () async {
        Object? param;
        const expectedResult = Object();
        final mockCallable = MockCallableWithNullableParamAndResult();
        when(mockCallable.call(param)).thenReturn(expectedResult);
        final unit = TwoWayCommand.withParam(mockCallable);

        final actualResult = unit.call(param);

        expect(actualResult, expectedResult);
      },
    );

    test(
      'should throw UnsupportedError if parameter is null and execute does not accept nullable parameter when called',
      () async {
        Object? param;
        final unit = TwoWayCommand.withParam<Object, Object>((p0) => Object());

        expect(() => unit.call(param), throwsUnsupportedError);
      },
    );

    test('should not execute if canExecute is false when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      unit.call(param);

      verifyNever(mockCallable.call(param));
    });

    test('should return null if canExecute is false when called', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = unit.call(param);

      expect(actualResult, isNull);
    });

    test('should return null if canExecute is false when called using itself', () async {
      const Object param = Object();
      when(mockCallable.call(param)).thenReturn(anything);
      final unit = createUnit();

      unit.canExecute.value = false;
      final actualResult = unit(param);

      expect(actualResult, isNull);
    });
  });
}
