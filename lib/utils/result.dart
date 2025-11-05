sealed class Result<T>{
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;

  bool get isOk => this is Ok<T>;
  bool get isError => this is Error<T>;

}

/// OK Result : Used when we have success response
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;


  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Error Result : Used when we have error response
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}