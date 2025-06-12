import 'package:dio/dio.dart';
import 'package:junior_flutter/core/internet_services/dio_exception.dart' as custom_dio_exception;
import 'package:junior_flutter/core/internet_services/paths.dart';
import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/wishList_repository.dart';

class WishListRepositoryImpl implements WishListRepository {
  final Dio _dio;

  WishListRepositoryImpl(this._dio);

  @override
  Future<List<WishListItem>> getAllWishLists() async {
    try {
      final response = await _dio.get(wishListsPath);
      return (response.data as List<dynamic>)
          .map((json) => WishListItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<WishListItem?> getWishListById(int id) async {
    try {
      final response = await _dio.get('$wishListsPath/$id');
      return WishListItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<WishListItem> addWishList(WishListItem wish) async {
    try {
      final response = await _dio.post(
        wishListsPath,
        data: wish.toJsonForCreate(),
      );
      return WishListItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }

  @override
  Future<WishListItem?> updateWishList(WishListItem wish) async {
    try {
      if (wish.id == null) {
        throw custom_dio_exception.DioException('Wish list ID is required for update');
      }
      final response = await _dio.patch(
        '$wishListsPath/${wish.id}',
        data: wish.toJsonForPatch(),
      );
      return WishListItem.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      if (e.response?.statusCode == 404) return null; // Handle not found
      throw error.errorMessage;
    }
  }

  @override
  Future<void> deleteWishList(int id) async {
    try {
      await _dio.delete('$wishListsPath/$id');
    } on DioException catch (e) {
      final error = custom_dio_exception.DioException.fromDioError(e);
      throw error.errorMessage;
    }
  }
}