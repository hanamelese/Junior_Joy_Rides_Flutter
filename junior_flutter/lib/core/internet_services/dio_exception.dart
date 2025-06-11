import 'package:dio/dio.dart' as dio;

class DioException implements Exception {
  late String errorMessage;

  DioException(this.errorMessage);

  DioException.fromDioError(dio.DioException dioException) {
    print('Processing DioException: type=${dioException.type}, message=${dioException.message}, response=${dioException.response?.data}, statusCode=${dioException.response?.statusCode}');
    switch (dioException.type) {
      case dio.DioExceptionType.cancel:
        errorMessage = "Request to the server was cancelled.";
        break;
      case dio.DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out.";
        break;
      case dio.DioExceptionType.receiveTimeout:
        errorMessage = "Receiving timeout occurred.";
        break;
      case dio.DioExceptionType.sendTimeout:
        errorMessage = "Request send timeout.";
        break;
      case dio.DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioException.response?.statusCode);
        break;
      case dio.DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred: ${dioException.message}';
        break;
      default:
        errorMessage = 'Something went wrong: ${dioException.message ?? "No additional details"}';
        break;
    }
  }

  String _handleStatusCode(int? statusCode) {
    print('Handling status code: $statusCode');
    switch (statusCode) {
      case 400:
        return 'User already exists';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong! (Status: $statusCode)';
    }
  }

  @override
  String toString() => errorMessage;
}