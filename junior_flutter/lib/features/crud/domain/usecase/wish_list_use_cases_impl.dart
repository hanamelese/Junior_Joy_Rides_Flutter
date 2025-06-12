import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/wishList_repository.dart';
import 'package:junior_flutter/features/crud/domain/usecase/wish_list_use_cases.dart';

class WishListUseCasesImpl implements WishListUseCases {
  @override
  final WishListRepository repository;

  WishListUseCasesImpl(this.repository);

  @override
  Future<List<WishListItem>> getAllWishLists() => repository.getAllWishLists();

  @override
  Future<WishListItem?> getWishListById(int id) => repository.getWishListById(id);

  @override
  Future<WishListItem> addWishList(WishListItem wish) => repository.addWishList(wish);

  @override
  Future<WishListItem?> updateWishList(WishListItem wish) => repository.updateWishList(wish);

  @override
  Future<void> deleteWishList(int id) => repository.deleteWishList(id);
}