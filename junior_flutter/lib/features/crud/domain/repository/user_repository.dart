import 'package:junior_flutter/features/crud/domain/model/userItem.dart';

abstract class UserRepository {

  // Register a new user, returns a JWT token
  Future<String> registerUser(UserItem user);

  // Login a user, returns a JWT token
  Future<String> loginUser(UserItem user);

  // Get user profile by email
  Future<UserItem> getUserProfile();

  // Update user profile, returns updated profile or new token if email changes
  Future<dynamic> updateUserProfile(UserItem user);

  //logout
  Future<void> logout();
}




