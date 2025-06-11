import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/features/crud/domain/repository/invitation_repository.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/invitation_repository_implementation.dart';

final invitationRepositoryProvider = Provider<InvitationRepository>((ref) {
  final dio = DioClient.instance.dio;
  return InvitationRepositoryImpl(dio);
});