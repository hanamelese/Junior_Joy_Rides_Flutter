// import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
// import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
// import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
// import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';
//
// class UserItem {
//   int? id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? password; // Only used for registration and login
//   String? profileImageUrl;
//   String? backgroundImageUrl;
//   String? role;
//   List<InvitationItem>? invitations;
//   List<BasicInterviewItem>? basicInterviews;
//   List<SpecialInterviewItem>? specialInterviews;
//   List<WishListItem>? wishLists;
//
//   UserItem({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.password,
//     this.profileImageUrl,
//     this.backgroundImageUrl,
//     this.role,
//     this.invitations,
//     this.basicInterviews,
//     this.specialInterviews,
//     this.wishLists,
//   });
//
//   UserItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as int?;
//     firstName = json['firstName'] as String?;
//     lastName = json['lastName'] as String?;
//     email = json['email'] as String?;
//     password = json['password'] as String?; // Typically null in responses
//     profileImageUrl = json['profileImageUrl'] as String?;
//     backgroundImageUrl = json['backgroundImageUrl'] as String?;
//     role = json['role'] as String?;
//     if (json['invitations'] != null) {
//       invitations = (json['invitations'] as List<dynamic>)
//           .map((e) => InvitationItem.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//     if (json['basicInterviews'] != null) {
//       basicInterviews = (json['basicInterviews'] as List<dynamic>)
//           .map((e) => BasicInterviewItem.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//     if (json['specialInterviews'] != null) {
//       specialInterviews = (json['specialInterviews'] as List<dynamic>)
//           .map((e) => SpecialInterviewItem.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//     if (json['wishLists'] != null) {
//       wishLists = (json['wishLists'] as List<dynamic>)
//           .map((e) => WishListItem.fromJson(e as Map<String, dynamic>))
//           .toList();
//     }
//   }
//
//   Map<String, dynamic> toJson({List<String> includeFields = const []}) {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // If no fields specified, include all non-null fields except relationships
//     final fields = includeFields.isEmpty
//         ? [
//       'id',
//       'firstName',
//       'lastName',
//       'email',
//       'password',
//       'profileImageUrl',
//       'backgroundImageUrl',
//       'role'
//     ]
//         : includeFields;
//
//     if (fields.contains('id') && id != null) data['id'] = id;
//     if (fields.contains('firstName') && firstName != null) data['firstName'] = firstName;
//     if (fields.contains('lastName') && firstName != null) data['lastName'] = lastName;
//     if (fields.contains('email') && email != null) data['email'] = email;
//     if (fields.contains('password') && password != null) data['password'] = password;
//     if (fields.contains('profileImageUrl') && profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;
//     if (fields.contains('backgroundImageUrl') && backgroundImageUrl != null) data['backgroundImageUrl'] = backgroundImageUrl;
//     if (fields.contains('role') && role != null) data['role'] = role;
//
//     // Include relationships only if explicitly requested
//     if (fields.contains('invitations') && invitations != null) {
//       data['invitations'] = invitations!.map((e) => e.toJson()).toList();
//     }
//     if (fields.contains('basicInterviews') && basicInterviews != null) {
//       data['basicInterviews'] = basicInterviews!.map((e) => e.toJson()).toList();
//     }
//     if (fields.contains('specialInterviews') && specialInterviews != null) {
//       data['specialInterviews'] = specialInterviews!.map((e) => e.toJson()).toList();
//     }
//     if (fields.contains('wishLists') && wishLists != null) {
//       data['wishLists'] = wishLists!.map((e) => e.toJson()).toList();
//     }
//
//     return data;
//   }
//
//   // Convenience method for login
//   Map<String, dynamic> toJsonForLogin() {
//     return toJson(includeFields: ['email', 'password']);
//   }
//
//   // Convenience method for registration
//   Map<String, dynamic> toJsonForRegistration() {
//     return toJson(includeFields: ['firstName', 'lastName', 'email', 'password']);
//   }
//
//   // Convenience method for PUT updates
//   Map<String, dynamic> toJsonForPut() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['firstName'] = firstName;
//     data['lastName'] = lastName;
//     data['email'] = email;
//     data['password'] = password;
//     data['profileImageUrl'] = profileImageUrl;
//     data['backgroundImageUrl'] = backgroundImageUrl;
//     return data;
//   }
// }


import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';

class UserItem {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password; // Only used for registration and login
  String? profileImageUrl;
  String? backgroundImageUrl;
  String? role;
  List<InvitationItem>? invitations;
  List<BasicInterviewItem>? basicInterviews;
  List<SpecialInterviewItem>? specialInterviews;
  List<WishListItem>? wishLists;

  UserItem({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.profileImageUrl,
    this.backgroundImageUrl,
    this.role,
    this.invitations,
    this.basicInterviews,
    this.specialInterviews,
    this.wishLists,
  });

  UserItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?; // Typically null in responses
    profileImageUrl = json['profileImageUrl'] as String?;
    backgroundImageUrl = json['backgroundImageUrl'] as String?;
    role = json['role'] as String?;
    if (json['invitations'] != null) {
      invitations = (json['invitations'] as List<dynamic>)
          .map((e) => InvitationItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json['basicInterviews'] != null) {
      basicInterviews = (json['basicInterviews'] as List<dynamic>)
          .map((e) => BasicInterviewItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json['specialInterviews'] != null) {
      specialInterviews = (json['specialInterviews'] as List<dynamic>)
          .map((e) => SpecialInterviewItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json['wishLists'] != null) {
      wishLists = (json['wishLists'] as List<dynamic>)
          .map((e) => WishListItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson({List<String> includeFields = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    final fields = includeFields.isEmpty
        ? [
      'id',
      'firstName',
      'lastName',
      'email',
      'password',
      'profileImageUrl',
      'backgroundImageUrl',
      'role'
    ]
        : includeFields;

    if (fields.contains('id') && id != null) data['id'] = id;
    if (fields.contains('firstName') && firstName != null) data['firstName'] = firstName;
    if (fields.contains('lastName') && lastName != null) data['lastName'] = lastName;
    if (fields.contains('email') && email != null) data['email'] = email;
    if (fields.contains('password') && password != null) data['password'] = password;
    if (fields.contains('profileImageUrl') && profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;
    if (fields.contains('backgroundImageUrl') && backgroundImageUrl != null) data['backgroundImageUrl'] = backgroundImageUrl;
    if (fields.contains('role') && role != null) data['role'] = role;

    if (fields.contains('invitations') && invitations != null) {
      data['invitations'] = invitations!.map((e) => e.toJson()).toList();
    }
    if (fields.contains('basicInterviews') && basicInterviews != null) {
      data['basicInterviews'] = basicInterviews!.map((e) => e.toJson()).toList();
    }
    if (fields.contains('specialInterviews') && specialInterviews != null) {
      data['specialInterviews'] = specialInterviews!.map((e) => e.toJson()).toList();
    }
    if (fields.contains('wishLists') && wishLists != null) {
      data['wishLists'] = wishLists!.map((e) => e.toJson()).toList();
    }

    return data;
  }

  Map<String, dynamic> toJsonForLogin() {
    return toJson(includeFields: ['email', 'password']);
  }

  Map<String, dynamic> toJsonForRegistration() {
    return toJson(includeFields: ['firstName', 'lastName', 'email', 'password']);
  }

  Map<String, dynamic> toJsonForPut() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['profileImageUrl'] = profileImageUrl;
    data['backgroundImageUrl'] = backgroundImageUrl;
    return data;
  }

  Map<String, dynamic> toJsonForPatch() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (firstName != null && firstName!.isNotEmpty) data['firstName'] = firstName;
    if (lastName != null && lastName!.isNotEmpty) data['lastName'] = lastName;
    if (email != null && email!.isNotEmpty) data['email'] = email;
    if (password != null && password!.isNotEmpty) data['password'] = password;
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) data['profileImageUrl'] = profileImageUrl;
    else if (profileImageUrl == null || profileImageUrl!.isEmpty) data['profileImageUrl'] = ''; // Retain existing if unchanged
    if (backgroundImageUrl != null && backgroundImageUrl!.isNotEmpty) data['backgroundImageUrl'] = backgroundImageUrl;
    else if (backgroundImageUrl == null || backgroundImageUrl!.isEmpty) data['backgroundImageUrl'] = ''; // Retain existing if unchanged
    return data;
  }
}