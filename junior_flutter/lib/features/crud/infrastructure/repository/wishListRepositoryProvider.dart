import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/core/internet_services/dio_client.dart';
import 'package:junior_flutter/features/crud/domain/repository/wishList_repository.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/wishList_repository_implementation.dart';

final wishListRepositoryProvider = Provider<WishListRepository>((ref) {
  final dio = DioClient.instance.dio;
  return WishListRepositoryImpl(dio);
});