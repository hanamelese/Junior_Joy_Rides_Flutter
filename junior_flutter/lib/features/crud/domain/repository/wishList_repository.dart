import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';

abstract class WishListRepository {
  Future<List<WishListItem>> getAllWishLists();
  Future<WishListItem?> getWishListById(int id); // Nullable if not found
  Future<WishListItem> addWishList(WishListItem wish);
  Future<WishListItem?> updateWishList(WishListItem wish);
  Future<void> deleteWishList(int id);
}