import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
import 'package:junior_flutter/core/internet_services/paths.dart';
import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/specialInterview_repository.dart';

class SpecialInterviewRepositoryImpl implements SpecialInterviewRepository {
  final Dio _dio;

  SpecialInterviewRepositoryImpl(this._dio);

  @override
  Future<List<SpecialInterviewItem>> getAllSpecialInterviews() async {
    try {
      final response = await _dio.get(specialInterviewPath);
      return (response.data as List<dynamic>)
          .map((json) => SpecialInterviewItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<SpecialInterviewItem?> getSpecialInterviewById(int id) async {
    try {
      final response = await _dio.get('$specialInterviewPath/$id');
      return SpecialInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<SpecialInterviewItem> addSpecialInterview(SpecialInterviewItem specialInterview) async {
    try {
      final response = await _dio.post(
        specialInterviewPath,
        data: specialInterview.toJsonForCreate(),
      );
      return SpecialInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<SpecialInterviewItem?> updateSpecialInterview(SpecialInterviewItem specialInterview) async {
    try {
      if (specialInterview.id == null) {
        throw custom_dio_exception.DioException('Interview ID is required for update');
      }
      final response = await _dio.patch(
        '$specialInterviewPath/${specialInterview.id}',
        data: specialInterview.toJsonForPatch(),
      );
      return SpecialInterviewItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<void> deleteSpecialInterview(int id) async {
    try {
      await _dio.delete('$specialInterviewPath/$id');
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}