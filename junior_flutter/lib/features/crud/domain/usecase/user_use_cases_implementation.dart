import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';
import 'package:junior_flutter/features/crud/domain/usecase/user_use_cases.dart';
import 'package:junior_flutter/features/crud/domain/model/userItem.dart';

class UserUseCasesImpl implements UserUseCases {
  @override
  final UserRepository repository;

  UserUseCasesImpl(this.repository);

  @override
  Future<String> registerUser(UserItem user) => repository.registerUser(user);

  @override
  Future<String> loginUser(UserItem user) => repository.loginUser(user);

  @override
  Future<UserItem> getUserProfile() => repository.getUserProfile();

  @override
  Future<dynamic> updateUserProfile(UserItem updatedUser) => repository.updateUserProfile(updatedUser);

  @override
  Future<void> logout() => repository.logout();
}