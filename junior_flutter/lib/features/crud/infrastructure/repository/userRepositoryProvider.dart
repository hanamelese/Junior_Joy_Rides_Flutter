// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';
// import 'package:junior_flutter/features/crud/infrastructure/repository/user_repository_implementation.dart';
//
// /// Provider for Dio instance
// final dioProvider = Provider<Dio>((ref) {
//   return Dio(); // You can customize Dio here (baseUrl, interceptors, etc.)
// });
//
// /// Provider for UserRepository
// final userRepositoryProvider = Provider<UserRepository>((ref) {
//   final dio = ref.watch(dioProvider);
//   return UserRepositoryImpl(dio);
// });


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/user_repository_implementation.dart';

/// Provider for UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(DioClient.instance.dio); // Inject Dio from DioClient
});