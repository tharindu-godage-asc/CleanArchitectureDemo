/// Represents a failure that can occur during a domain operation.
///
/// [statusCode] optionally contains the HTTP status code associated with
/// the failure when the failure originates from an HTTP response.
sealed class Failure {
  new({this.statusCode});

  final int? statusCode;
}

class CacheFailure extends Failure {}

class NotFoundFailure extends Failure {}
