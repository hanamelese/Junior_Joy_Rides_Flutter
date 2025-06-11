import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/features/crud/domain/repository/basicInterview_repository.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/basicInterview_repository_implementation.dart';

final basicInterviewRepositoryProvider = Provider<BasicInterviewRepository>((ref) {
  final dio = DioClient.instance.dio;
  return BasicInterviewRepositoryImpl(dio);
});