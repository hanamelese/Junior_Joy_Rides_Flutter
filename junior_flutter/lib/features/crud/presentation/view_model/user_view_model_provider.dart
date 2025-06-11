import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
import 'package:junior_flutter/features/crud/domain/usecase/user_use_cases_provider.dart';

class UserProvider extends ChangeNotifier {
  final Ref ref;
  bool loading = false;
  String? error;
  UserItem? user;
  String? token;
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
  final profileImageUrlCtr = TextEditingController();
  final backgroundImageUrlCtr = TextEditingController();

  UserProvider(this.ref);

  Future<void> registerUser() async {
    print('registerUser called, loading: $loading');
    if (loading) {
      print('Operation aborted: Already loading');
      return;
    }
    loading = true;
    error = null;
    notifyListeners();
    print('Starting registration, loading set to true');

    try {
      final userItem = UserItem(
        firstName: firstNameCtr.text,
        lastName: lastNameCtr.text,
        email: emailCtr.text,
        password: passwordCtr.text,
      );
      print('UserItem created: ${userItem.toJsonForRegistration()}');
      token = await ref.read(userUseCasesProvider).registerUser(userItem);
      print('Registered with token: $token');
    } catch (e) {
      error = e.toString();
      print('Registration error: $error');
    } finally {
      loading = false;
      notifyListeners();
      print('Registration completed, loading: $loading, error: $error');
      if (error == null && token != null) {
        await fetchUserProfile();
      }
    }
  }

  Future<void> loginUser() async {
    print('loginUser called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final userItem = UserItem(
        email: emailCtr.text,
        password: passwordCtr.text,
      );
      token = await ref.read(userUseCasesProvider).loginUser(userItem);
      print('Logged in with token: $token');
      await fetchUserProfile();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> loginAdmin() async {
    print('loginAdmin called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final userItem = UserItem(
        email: emailCtr.text,
        password: passwordCtr.text,
      );
      token = await ref.read(userUseCasesProvider).loginUser(userItem); // Reuse login logic
      print('Logged in with token: $token');
      if (token == null) {
        throw Exception('Login failed: No token received');
      }
      // Fetch user profile and wait for completion

      await fetchUserProfile();
      print('Fetched user data after loginAdmin: ${user?.toJson()}');

      // Check if user role is "admin" after fetching profile
      if (user == null) {
        error = 'User data not found after login';
        token = null;
        print('Login failed: User data is null');
      } else if (user!.role == null) {
        error = 'Role information missing from user data; please contact support to enable admin access';
        token = null;
        user = null;
        print('Login failed: User role is null. Full data: ${user?.toJson()}');
      } else if (user!.role!.toLowerCase() != 'admin') {
        error = 'Access denied: Admin role required';
        token = null;
        user = null;
        print('Login failed: User role ${user!.role} is not admin');
      } else {
        print('Admin login successful for user: ${user?.toJson()}');
      }
    } catch (e) {
      error = e.toString();
      if (e.toString().contains('401')) {
        error = 'Unauthorized: Please check your admin credentials';
      }
      print('Admin login error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      user = await ref.read(userUseCasesProvider).getUserProfile();
      print('Fetched user: ${user?.toJson()}'); // <-- Add this
      notifyListeners();
    } catch (e) {
      error = 'Error fetching user: $e';
      print(error);
    }
  }


  Future<void> updateUserProfile() async {
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final originalUser = user ?? UserItem();
      final updatedUser = UserItem(
        id: originalUser.id,
        firstName: firstNameCtr.text.isNotEmpty ? firstNameCtr.text : originalUser.firstName,
        lastName: lastNameCtr.text.isNotEmpty ? lastNameCtr.text : originalUser.lastName,
        email: emailCtr.text.isNotEmpty ? emailCtr.text : originalUser.email,
        password: passwordCtr.text.isNotEmpty ? passwordCtr.text : originalUser.password,
        profileImageUrl: profileImageUrlCtr.text.isNotEmpty ? profileImageUrlCtr.text : originalUser.profileImageUrl,
        backgroundImageUrl: backgroundImageUrlCtr.text.isNotEmpty ? backgroundImageUrlCtr.text : originalUser.backgroundImageUrl,
      );
      final updatedUserResponse = await ref.read(userUseCasesProvider).updateUserProfile(updatedUser);
      user = updatedUserResponse is Map<String, dynamic> ? UserItem.fromJson(updatedUserResponse) : updatedUserResponse as UserItem?;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      await ref.read(userUseCasesProvider).logout();
      user = null;
      token = null;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clear() {
    emailCtr.clear();
    passwordCtr.clear();
    firstNameCtr.clear();
    lastNameCtr.clear();
    profileImageUrlCtr.clear();
    backgroundImageUrlCtr.clear();
    error = null;
    token = null;
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider(ref));