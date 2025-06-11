// import 'package:dio/dio.dart';
// import 'package:junior_flutter/core/internet_services/dio_client.dart';
// import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
// import 'package:junior_flutter/core/internet_services/paths.dart';
// import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
// import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';
//
// class UserRepositoryImpl implements UserRepository {
//   final Dio _dio;
//
//   UserRepositoryImpl(this._dio);
//
//   @override
//   Future<String> registerUser(UserItem user) async {
//     try {
//       final response = await _dio.post(
//         register,
//         data: user.toJsonForRegistration(),
//       );
//       final token = response.data['token'] as String;
//       DioClient.instance.setToken(token);
//       return token;
//     } on DioException catch (e) {
//       final error = custom_dio_exception.DioException.fromDioError(e);
//       throw error.errorMessage;
//     }
//   }
//
//   @override
//   Future<String> loginUser(UserItem userLogin) async {
//     try {
//       final response = await _dio.post(
//         login,
//         data: userLogin.toJsonForLogin(),
//       );
//       final token = response.data['token'] as String;
//       DioClient.instance.setToken(token);
//       return token;
//     } on DioException catch (e) {
//       final error = custom_dio_exception.DioException.fromDioError(e);
//       throw error.errorMessage;
//     }
//   }
//
//   // @override
//   // Future<UserItem> getUserProfile() async {
//   //   try {
//   //     final response = await _dio.get(myProfile);
//   //     return UserItem.fromJson(response.data);
//   //   } on DioException catch (e) {
//   //     final error = custom_dio_exception.DioException.fromDioError(e);
//   //     throw error.errorMessage;
//   //   }
//   // }
//
//   Future<UserItem> getUserProfile() async {
//     try {
//       print('Fetching profile from: $myProfile');
//       final response = await _dio.get(myProfile);
//       print('Profile API response: status=${response.statusCode}, data=${response.data}');
//       if (response.data == null) {
//         throw 'Server returned null response';
//       }
//       final user = UserItem.fromJson(response.data);
//       print('Parsed UserItem: ${user.toJson()}');
//       return user;
//     } on DioException catch (e) {
//       final error = custom_dio_exception.DioException.fromDioError(e);
//       print('Profile fetch DioException: $error');
//       throw error.errorMessage;
//     } catch (e) {
//       print('Unexpected error fetching profile: $e');
//       throw e.toString();
//     }
//   }
//
//   @override
//   Future<dynamic> updateUserProfile(UserItem user) async {
//     try {
//       final response = await _dio.put(
//         editProfile,
//         data: user.toJsonForPut(),
//       );
//       if (response.data['token'] != null) {
//         final token = response.data['token'] as String;
//         DioClient.instance.setToken(token);
//         return {'token': token};
//       }
//       return UserItem.fromJson(response.data);
//     } on DioException catch (e) {
//       final error = custom_dio_exception.DioException.fromDioError(e);
//       throw error.errorMessage;
//     }
//   }
//
//   @override
//   Future<void> logout() async {
//     try {
//       DioClient.instance.clearToken();
//     } catch (e) {
//       throw custom_dio_exception.DioException('Failed to logout: $e');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
import 'package:junior_flutter/core/internet_services/paths.dart';
import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<String> registerUser(UserItem user) async {
    try {
      final response = await _dio.post(
        register,
        data: user.toJsonForRegistration(),
      );
      final token = response.data['token'] as String;
      DioClient.instance.setToken(token);
      return token;
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<String> loginUser(UserItem userLogin) async {
    try {
      final response = await _dio.post(
        login,
        data: userLogin.toJsonForLogin(),
      );
      final token = response.data['token'] as String;
      DioClient.instance.setToken(token);
      return token;
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  Future<UserItem> getUserProfile() async {
    try {
      print('Fetching profile from: $myProfile');
      final response = await _dio.get(myProfile);
      print('Profile API response: status=${response.statusCode}, data=${response.data}');
      if (response.data == null) {
        throw 'Server returned null response';
      }
      final user = UserItem.fromJson(response.data);
      print('Parsed UserItem: ${user.toJson()}');
      return user;
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      print('Profile fetch DioException: $error');
      throw error.errorMessage;
    } catch (e) {
      print('Unexpected error fetching profile: $e');
      throw e.toString();
    }
  }

  @override
  Future<dynamic> updateUserProfile(UserItem user) async  {
    try {
      final response = await _dio.patch(
        editProfile,
        data: user.toJsonForPatch(), // Send as PUT, but with PATCH-like data
      );
      if (response.data['token'] != null) {
        final token = response.data['token'] as String;
        DioClient.instance.setToken(token);
        return {'token': token};
      }
      return UserItem.fromJson(response.data);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<void> logout() async {
    try {
      DioClient.instance.clearToken();
    } catch (e) {
      throw custom_dio_exception.DioException('Failed to logout: $e');
    }
  }
}