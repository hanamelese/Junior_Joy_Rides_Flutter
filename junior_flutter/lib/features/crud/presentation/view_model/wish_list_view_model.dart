
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
import 'package:junior_flutter/features/crud/domain/usecase/wish_list_use_cases_provider.dart';

class WishListProvider extends ChangeNotifier {
  final Ref ref;
  bool loading = false;
  String? error;
  List<WishListItem> wishLists = [];
  WishListItem? currentWishList;
  final childNameCtr = TextEditingController();
  final guardianEmailCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final dateCtr = TextEditingController();
  final specialRequestsCtr = TextEditingController();
  final imageUrlCtr = TextEditingController();
  bool? upcoming = true;
  bool? approved = false;
  int? id;

  WishListProvider(this.ref);

  Future<void> fetchAllWishLists() async {
    print('fetchAllWishLists called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      wishLists = await ref.read(wishListUseCasesProvider).getAllWishLists();
      print('Fetched ${wishLists.length} wish lists');
    } catch (e) {
      error = e.toString();
      print('Fetch all wish lists error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWishListById(int wishListId) async {
    print('fetchWishListById called for id: $wishListId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      currentWishList = await ref.read(wishListUseCasesProvider).getWishListById(wishListId);
      print('fetchWishListById response: currentWishList=$currentWishList, raw data=${currentWishList?.toJson()}');
      if (currentWishList != null) {
        id = currentWishList!.id;
        childNameCtr.text = currentWishList!.childName ?? '';
        guardianEmailCtr.text = currentWishList!.guardianEmail ?? '';
        ageCtr.text = currentWishList!.age?.toString() ?? '';
        dateCtr.text = currentWishList!.date ?? '';
        specialRequestsCtr.text = currentWishList!.specialRequests ?? '';
        imageUrlCtr.text = currentWishList!.imageUrl ?? '';
        upcoming = currentWishList!.upcoming;
        approved = currentWishList!.approved;
        print('Fetched wish list: ${currentWishList!.toJson()}, id: $id');
      } else {
        error = 'Wish list not found';
        print('Wish list not found for id: $wishListId');
      }
    } catch (e) {
      error = e.toString();
      print('Fetch wish list error: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> saveWishList() async {
    print('saveWishList called, id: $id');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final wishList = WishListItem(
        id: id,
        childName: childNameCtr.text.isNotEmpty ? childNameCtr.text : null,
        guardianEmail: guardianEmailCtr.text.isNotEmpty ? guardianEmailCtr.text : null,
        age: int.tryParse(ageCtr.text),
        date: dateCtr.text.isNotEmpty ? dateCtr.text : null,
        specialRequests: specialRequestsCtr.text.isNotEmpty ? specialRequestsCtr.text : null,
        imageUrl: imageUrlCtr.text.isNotEmpty ? imageUrlCtr.text : null,
        upcoming: upcoming,
        approved: approved,
      );

      if (id == null) {
        print('Creating new wish list');
        currentWishList = await ref.read(wishListUseCasesProvider).addWishList(wishList);
        id = currentWishList!.id;
        print('Added new wish list: ${currentWishList!.toJson()}, id: $id');
      } else {
        print('Updating wish list with id: $id');
        currentWishList = await ref.read(wishListUseCasesProvider).updateWishList(wishList);
        if (currentWishList == null) {
          error = 'Failed to update wish list';
          print('Update returned null for id: $id');
        } else {
          print('Updated wish list: ${currentWishList!.toJson()}, id: $id');
        }
      }
    } catch (e) {
      error = e.toString();
      print('Save wish list error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteWishList(int wishListId) async {
    print('deleteWishList called for id: $wishListId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      await ref.read(wishListUseCasesProvider).deleteWishList(wishListId);
      wishLists.removeWhere((wishList) => wishList.id == wishListId);
      if (currentWishList?.id == wishListId) {
        currentWishList = null;
        clear();
      }
      print('Deleted wish list id: $wishListId');
    } catch (e) {
      error = e.toString();
      print('Delete wish list error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setUpcoming(bool? value) {
    upcoming = value;
    notifyListeners();
  }

  void setApproved(bool? value) {
    approved = value;
    notifyListeners();
  }

  void clear() {
    id = null;
    childNameCtr.clear();
    guardianEmailCtr.clear();
    ageCtr.clear();
    dateCtr.clear();
    specialRequestsCtr.clear();
    imageUrlCtr.clear();
    upcoming = true;
    approved = false;
    error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    childNameCtr.dispose();
    guardianEmailCtr.dispose();
    ageCtr.dispose();
    dateCtr.dispose();
    specialRequestsCtr.dispose();
    imageUrlCtr.dispose();
    super.dispose();
  }
}

final wishListProvider = ChangeNotifierProvider<WishListProvider>((ref) => WishListProvider(ref));