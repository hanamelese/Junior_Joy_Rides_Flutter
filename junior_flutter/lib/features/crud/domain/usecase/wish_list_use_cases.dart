import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/wishList_repository.dart';

abstract class WishListUseCases {
  final WishListRepository repository;

  WishListUseCases(this.repository);

  Future<List<WishListItem>> getAllWishLists();
  Future<WishListItem?> getWishListById(int id);
  Future<WishListItem> addWishList(WishListItem wish);
  Future<WishListItem?> updateWishList(WishListItem wish);
  Future<void> deleteWishList(int id);
}