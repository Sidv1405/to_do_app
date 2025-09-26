import 'package:dio/dio.dart';

import 'api_exception.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException e) {
    // Timeout
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkException("Connection timeout");
    }

    // check connect
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      return const NetworkException("Network error");
    }

    // handle response errors
    if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data.toString() ?? "Unknown error";

      return switch (statusCode) {
        400 => BadRequestException(message),
        401 => UnauthorizedException(message),
        403 => ForbiddenException(message),
        404 => NotFoundException(message),
        500 => InternalServerErrorException(message),
        _ => UnknownServerException(message, code: statusCode),
      };
    }

    return UnexpectedClientException(e.message ?? "Unexpected error");
  }
}
