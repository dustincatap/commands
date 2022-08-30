import 'package:mockito/annotations.dart';

export 'callable.mocks.dart';

@GenerateMocks([Callable])
abstract class Callable {
  void call();
}

@GenerateMocks([CallableWithParam])
abstract class CallableWithParam {
  void call(Object param);
}

@GenerateMocks([CallableWithNullableParam])
abstract class CallableWithNullableParam {
  void call(Object? param);
}

@GenerateMocks([AsyncCallable])
abstract class AsyncCallable {
  Future<void> call();
}

@GenerateMocks([AsyncCallableWithParam])
abstract class AsyncCallableWithParam {
  Future<void> call(Object param);
}

@GenerateMocks([AsyncCallableWithNullableParam])
abstract class AsyncCallableWithNullableParam {
  Future<void> call(Object? param);
}

@GenerateMocks([CallableWithResult])
abstract class CallableWithResult {
  Object call();
}

@GenerateMocks([CallableWithParamAndResult])
abstract class CallableWithParamAndResult {
  Object call(Object param);
}

@GenerateMocks([CallableWithNullableParamAndResult])
abstract class CallableWithNullableParamAndResult {
  Object call(Object? param);
}

@GenerateMocks([AsyncCallableWithResult])
abstract class AsyncCallableWithResult {
  Future<Object> call();
}

@GenerateMocks([AsyncCallableWithParamAndResult])
abstract class AsyncCallableWithParamAndResult {
  Future<Object> call(Object param);
}

@GenerateMocks([AsyncCallableWithNullableParamAndResult])
abstract class AsyncCallableWithNullableParamAndResult {
  Future<Object> call(Object? param);
}
