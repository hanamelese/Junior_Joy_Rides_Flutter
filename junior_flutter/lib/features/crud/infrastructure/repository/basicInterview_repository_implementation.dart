import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
import 'package:junior_flutter/core/internet_services/paths.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/basicInterview_repository.dart';

class BasicInterviewRepositoryImpl implements BasicInterviewRepository {
  final Dio _dio;

  BasicInterviewRepositoryImpl(this._dio);

  @override
  Future<List<BasicInterviewItem>> getAllBasicInterviews() async {
    try {
      final response = await _dio.get(basicInterviewPath);
      return (response.data as List<dynamic>)
          .map((json) => BasicInterviewItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<BasicInterviewItem?> getBasicInterviewById(int id) async {
    try {
      final response = await _dio.get('$basicInterviewPath/$id');
      return BasicInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<BasicInterviewItem> addBasicInterview(BasicInterviewItem basicInterview) async {
    try {
      // if (basicInterview.userId == null) {
      //   throw custom_dio_exception.DioException('userId is required for creating a basic interview');
      // }
      final response = await _dio.post(
        basicInterviewPath,
        data: basicInterview.toJsonForCreate(),
      );
      return BasicInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<BasicInterviewItem?> updateBasicInterview(BasicInterviewItem basicInterview) async {
    try {
      if (basicInterview.id == null) {
        throw custom_dio_exception.DioException('Interview ID is required for update');
      }
      final response = await _dio.patch(
        '$basicInterviewPath/${basicInterview.id}',
        data: basicInterview.toJsonForPatch(),
      );
      return BasicInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<void> deleteSpecialInterview(int id) async {
    try {
      await _dio.delete('$basicInterviewPath/$id');
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}