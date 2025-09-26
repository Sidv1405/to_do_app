sealed class ApiException implements Exception {
  final String message;
  final int? code;

  const ApiException(this.message, {this.code});

  @override
  String toString() => "ApiException(code: $code, message: $message)";
}

class BadRequestException extends ApiException {
  const BadRequestException(super.message) : super(code: 400);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message) : super(code: 401);
}

class ForbiddenException extends ApiException {
  const ForbiddenException(super.message) : super(code: 403);
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message) : super(code: 404);
}

class InternalServerErrorException extends ApiException {
  const InternalServerErrorException(super.message) : super(code: 500);
}

class NetworkException extends ApiException {
  const NetworkException(super.message) : super(code: null);
}

class UnknownServerException extends ApiException {
  const UnknownServerException(super.message, {super.code});
}

class UnexpectedClientException extends ApiException {
  const UnexpectedClientException(super.message);
}
