import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/usecase/wish_list_use_cases.dart';
import 'package:junior_flutter/features/crud/domain/usecase/wish_list_use_cases_impl.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/wishListRepositoryProvider.dart';

final wishListUseCasesProvider = Provider<WishListUseCasesImpl>((ref) {
  final repository = ref.watch(wishListRepositoryProvider);
  return WishListUseCasesImpl(repository);
});