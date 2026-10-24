import 'package:dio/dio.dart';

import '../failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ServerFailure('Connection timeout with API server');

        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);

        case DioExceptionType.cancel:
          return const ServerFailure('Request was cancelled');

        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          if (error.error != null && error.error.toString().contains('SocketException')) {
            return const NetworkFailure('No internet connection');
          }
          return const ServerFailure('An unexpected error occurred');

        default:
          return const ServerFailure('Something went wrong, please try again later');
      }
    } else {
      return UnexpectedFailure(error.toString());
    }
  }

  // Handle specific HTTP Status Codes
  static Failure _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;

    // Extract message from JSON body if present
    String? serverMessage;
    try {
      if (response?.data is Map<String, dynamic>) {
        serverMessage = response?.data['message'] ?? response?.data['error'];
      }
    } catch (_) {
      serverMessage = null;
    }

    switch (statusCode) {
      case 400:
        return ServerFailure(serverMessage ?? 'Bad Request (400)');
      case 401:
        return ServerFailure(serverMessage ?? 'Unauthorized access. Please log in again.');
      case 403:
        return ServerFailure(serverMessage ?? 'Access forbidden (403)');
      case 404:
        return ServerFailure(serverMessage ?? 'Resource not found (404)');
      case 409:
        return ServerFailure(serverMessage ?? 'Conflict occurred (409)');
      case 422:
        return ServerFailure(serverMessage ?? 'Unprocessable Entity / Validation Error (422)');
      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return ServerFailure(serverMessage ?? 'Internal server error. Please try again later.');
      default:
        return ServerFailure(serverMessage ?? 'Connection failed with status code: $statusCode');
    }
  }
}