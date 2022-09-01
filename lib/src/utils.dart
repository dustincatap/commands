UnsupportedError nullParamInNonNullableError<TIn>() {
  return UnsupportedError('parameter of type $TIn was null, but command only accepts non-nullable parameter');
}
