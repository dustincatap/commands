import 'package:mockito/annotations.dart';

export 'callable.mocks.dart';

@GenerateMocks([
  Callable,
  CallableWithParam,
  CallableWithNullableParam,
  AsyncCallable,
  AsyncCallableWithParam,
  AsyncCallableWithNullableParam,
  CallableWithResult,
  CallableWithParamAndResult,
  CallableWithNullableParamAndResult,
  AsyncCallableWithResult,
  AsyncCallableWithParamAndResult,
  AsyncCallableWithNullableParamAndResult,
])
abstract class Callable {
  void call();
}

abstract class CallableWithParam {
  void call(Object param);
}

abstract class CallableWithNullableParam {
  void call(Object? param);
}

abstract class AsyncCallable {
  Future<void> call();
}

abstract class AsyncCallableWithParam {
  Future<void> call(Object param);
}

abstract class AsyncCallableWithNullableParam {
  Future<void> call(Object? param);
}

abstract class CallableWithResult {
  Object call();
}

abstract class CallableWithParamAndResult {
  Object call(Object param);
}

abstract class CallableWithNullableParamAndResult {
  Object call(Object? param);
}

abstract class AsyncCallableWithResult {
  Future<Object> call();
}

abstract class AsyncCallableWithParamAndResult {
  Future<Object> call(Object param);
}

abstract class AsyncCallableWithNullableParamAndResult {
  Future<Object> call(Object? param);
}
