import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
import 'package:junior_flutter/core/internet_services/paths.dart';
import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/invitation_repository.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final Dio _dio;

  InvitationRepositoryImpl(this._dio);

  @override
  Future<List<InvitationItem>> getAllInvitations() async {
    try {
      final response = await _dio.get(invitationPath);
      return (response.data as List<dynamic>)
          .map((json) => InvitationItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<InvitationItem?> getInvitationById(int id) async {
    try {
      final response = await _dio.get('$invitationPath/$id');
      return InvitationItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<InvitationItem> addInvitation(InvitationItem invitation) async {
    try {
      final response = await _dio.post(
        invitationPath,
        data: invitation.toJsonForCreate(),
      );
      return InvitationItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<InvitationItem?> updateInvitation(InvitationItem invitation) async {
    try {
      if (invitation.id == null) {
        throw custom_dio_exception.DioException('Invitation ID is required for update');
      }
      final response = await _dio.patch(
        '$invitationPath/${invitation.id}',
        data: invitation.toJsonForPatch(),
      );
      return InvitationItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<void> deleteInvitation(int id) async {
    try {
      await _dio.delete('$invitationPath/$id');
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}