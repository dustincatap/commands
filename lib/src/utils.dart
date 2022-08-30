UnsupportedError nullParamInNonNullableError<T>() {
  return UnsupportedError('parameter of type $T was null, but command only accepts non-nullable parameter');
}
