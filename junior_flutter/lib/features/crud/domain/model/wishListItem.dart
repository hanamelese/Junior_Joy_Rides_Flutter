// class WishListItem {
//   int? id;
//   String? childName;
//   String? guardianEmail;
//   int? age;
//   String? date;
//   String? specialRequests;
//   String? imageUrl;
//   bool? upcoming;
//   bool? approved;
//   int? userId;
//
//   WishListItem({
//     this.id,
//     this.childName,
//     this.guardianEmail,
//     this.age,
//     this.date,
//     this.specialRequests,
//     this.imageUrl,
//     this.upcoming,
//     this.approved,
//     this.userId,
//   });
//
//   WishListItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as int?;
//     childName = json['childName'] as String?;
//     guardianEmail = json['guardianEmail'] as String?;
//     age = json['age'] as int?;
//     date = json['date'] as String?;
//     specialRequests = json['specialRequests'] as String?;
//     imageUrl = json['imageUrl'] as String?;
//     upcoming = json['upcoming'] as bool?;
//     approved = json['approved'] as bool?;
//     userId = json['userId'] as int?;
//   }
//
//   Map<String, dynamic> toJson({List<String> includeFields = const []}) {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // Default to all fields if none specified
//     final fields = includeFields.isEmpty
//         ? [
//       'id',
//       'childName',
//       'guardianEmail',
//       'age',
//       'date',
//       'specialRequests',
//       'imageUrl',
//       'upcoming',
//       'approved',
//       'userId',
//     ]
//         : includeFields;
//
//     if (fields.contains('id') && id != null) data['id'] = id;
//     if (fields.contains('childName') && childName != null) data['childName'] = childName;
//     if (fields.contains('guardianEmail') && guardianEmail != null) data['guardianEmail'] = guardianEmail;
//     if (fields.contains('age') && age != null) data['age'] = age;
//     if (fields.contains('date') && date != null) data['date'] = date;
//     if (fields.contains('specialRequests') && specialRequests != null) data['specialRequests'] = specialRequests;
//     if (fields.contains('imageUrl') && imageUrl != null) data['imageUrl'] = imageUrl;
//     if (fields.contains('upcoming') && upcoming != null) data['upcoming'] = upcoming;
//     if (fields.contains('approved') && approved != null) data['approved'] = approved;
//     if (fields.contains('userId') && userId != null) data['userId'] = userId;
//
//     return data;
//   }
//
//   // Convenience method for creating a new wish list
//   Map<String, dynamic> toJsonForCreate() {
//     return toJson(includeFields: [
//       'childName',
//       'guardianEmail',
//       'age',
//       'date',
//       'specialRequests',
//       'imageUrl',
//       'upcoming',
//       'approved',
//       'userId',
//     ]);
//   }
//
//   // Convenience method for PUT updates
//   Map<String, dynamic> toJsonForPut() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['childName'] = childName;
//     data['guardianEmail'] = guardianEmail;
//     data['age'] = age;
//     data['date'] = date;
//     data['specialRequests'] = specialRequests;
//     data['imageUrl'] = imageUrl;
//     data['upcoming'] = upcoming;
//     data['approved'] = approved;
//     data['userId'] = userId;
//     return data;
//   }
// }


class WishListItem {
  int? id;
  String? childName;
  String? guardianEmail;
  int? age;
  String? date;
  String? specialRequests;
  String? imageUrl;
  bool? upcoming;
  bool? approved;

  WishListItem({
    this.id,
    this.childName,
    this.guardianEmail,
    this.age,
    this.date,
    this.specialRequests,
    this.imageUrl,
    this.upcoming,
    this.approved,
  });

  WishListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    childName = json['childName'] as String?;
    guardianEmail = json['guardianEmail'] as String?;
    age = json['age'] as int?;
    date = json['date'] as String?;
    specialRequests = json['specialRequests'] as String?;
    imageUrl = json['imageUrl'] as String?;
    upcoming = json['upcoming'] as bool?;
    approved = json['approved'] as bool?;
  }

  Map<String, dynamic> toJson({List<String> includeFields = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    final fields = includeFields.isEmpty
        ? [
      'id',
      'childName',
      'guardianEmail',
      'age',
      'date',
      'specialRequests',
      'imageUrl',
      'upcoming',
      'approved',
    ]
        : includeFields;

    if (fields.contains('id') && id != null) data['id'] = id;
    if (fields.contains('childName') && childName != null) data['childName'] = childName;
    if (fields.contains('guardianEmail') && guardianEmail != null) data['guardianEmail'] = guardianEmail;
    if (fields.contains('age') && age != null) data['age'] = age;
    if (fields.contains('date') && date != null) data['date'] = date;
    if (fields.contains('specialRequests') && specialRequests != null) data['specialRequests'] = specialRequests;
    if (fields.contains('imageUrl') && imageUrl != null) data['imageUrl'] = imageUrl;
    if (fields.contains('upcoming') && upcoming != null) data['upcoming'] = upcoming;
    if (fields.contains('approved') && approved != null) data['approved'] = approved;

    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    return toJson(includeFields: [
      'childName',
      'guardianEmail',
      'age',
      'date',
      'specialRequests',
      'imageUrl',
      'upcoming',
      'approved',
    ]);
  }

  Map<String, dynamic> toJsonForPatch() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['childName'] = childName ?? '';
    data['guardianEmail'] = guardianEmail ?? '';
    data['age'] = age ?? 0;
    data['date'] = date ?? '';
    data['specialRequests'] = specialRequests ?? '';
    data['imageUrl'] = imageUrl ?? '';
    data['upcoming'] = upcoming ?? false;
    data['approved'] = approved ?? false;
    return data;
  }
}