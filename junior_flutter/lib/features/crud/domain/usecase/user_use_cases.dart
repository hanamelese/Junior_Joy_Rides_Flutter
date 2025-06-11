import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/user_repository.dart';

abstract class UserUseCases {
  final UserRepository repository;

  UserUseCases(this.repository);

  Future<String> registerUser(UserItem user);
  Future<String> loginUser(UserItem user);
  Future<UserItem> getUserProfile();
  Future<dynamic> updateUserProfile(UserItem updatedUser);
  Future<void> logout();
}