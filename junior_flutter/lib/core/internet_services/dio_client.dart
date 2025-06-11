import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/paths.dart';

/// Create a singleton class to contain all Dio methods and helper functions
class DioClient {
  DioClient._();

  static final instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ),
  );

  String? _token; // Store JWT token

  // Add a public getter for _dio
  Dio get dio => _dio;

  /// Initialize Dio with interceptors
  void initialize() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('Request path: ${options.path}'); // Log the path
          if (_token != null && _requiresAuth(options.path)) {
            options.headers['Authorization'] = 'Bearer $_token';
            print('Added Authorization header: Bearer $_token'); // Confirm token is added
          } else {
            print('No Authorization header added for path: ${options.path}');
          }
          return handler.next(options);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          print('DioError: statusCode=${error.response?.statusCode}, message=${error.message}');
          if (error.response?.statusCode == 401) {
            clearToken();
            throw UnauthorizedException('Token expired or invalid');
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Set JWT token after login/registration
  void setToken(String token) {
    _token = token;
    print('Token set in DioClient: $_token');
  }

  /// Clear JWT token on logout
  void clearToken() {
    _token = null;
  }

  /// Check if the endpoint requires authentication
  bool _requiresAuth(String path) {
    const authEndpoints = [
      '/user/my-profile',
      '/user/edit-profile',
      '/basic-interview',
      '/special-interview',
      '/wishLists',
      '/invitation',
      '/user/login',
      '/auth/login',

    ];
  //   final normalizedPath = path.startsWith('/') ? path : '/$path'; // Ensure leading slash
  //   return authEndpoints.any((endpoint) => normalizedPath == endpoint);
  // }

    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return authEndpoints.any((endpoint) => normalizedPath.startsWith(endpoint) || normalizedPath.contains('$endpoint/'));
  }

  /// Get Method
  Future<Map<String, dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Post Method
  Future<Map<String, dynamic>> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Put Method
  Future<Map<String, dynamic>> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Delete Method
  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 204) {
        return response.data;
      }
      throw "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }
}

/// Custom exception for unauthorized errors
class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}
