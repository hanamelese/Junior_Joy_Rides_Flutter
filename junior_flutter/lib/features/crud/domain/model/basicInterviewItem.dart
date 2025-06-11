class BasicInterviewItem {
  int? id;
  String? childName;
  String? guardianName;
  String? guardianPhone;
  int? age;
  String? guardianEmail;
  String? specialRequests;
  bool? upcoming;
  bool? approved;

  BasicInterviewItem({
    this.id,
    this.childName,
    this.guardianName,
    this.guardianPhone,
    this.age,
    this.guardianEmail,
    this.specialRequests,
    this.upcoming,
    this.approved,
  });

  BasicInterviewItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    childName = json['childName'] as String?;
    guardianName = json['guardianName'] as String?;
    guardianPhone = json['guardianPhone']?.toString();
    age = json['age'] as int?;
    guardianEmail = json['guardianEmail'] as String?;
    specialRequests = json['specialRequests'] as String?;
    upcoming = json['upcoming'] as bool?;
    approved = json['approved'] as bool?;
  }

  Map<String, dynamic> toJson({List<String> includeFields = const []}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    final fields = includeFields.isEmpty
        ? [
      'id',
      'childName',
      'guardianName',
      'guardianPhone',
      'age',
      'guardianEmail',
      'specialRequests',
      'upcoming',
      'approved',
    ]
        : includeFields;

    if (fields.contains('id') && id != null) data['id'] = id;
    if (fields.contains('childName') && childName != null) data['childName'] = childName;
    if (fields.contains('guardianName') && guardianName != null) data['guardianName'] = guardianName;
    if (fields.contains('guardianPhone') && guardianPhone != null) {
      final phoneNum = int.tryParse(guardianPhone!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      data['guardianPhone'] = phoneNum;
    }
    if (fields.contains('age') && age != null) data['age'] = age;
    if (fields.contains('guardianEmail') && guardianEmail != null) data['guardianEmail'] = guardianEmail;
    if (fields.contains('specialRequests') && specialRequests != null) data['specialRequests'] = specialRequests;
    if (fields.contains('upcoming') && upcoming != null) data['upcoming'] = upcoming;
    if (fields.contains('approved') && approved != null) data['approved'] = approved;

    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    return toJson(includeFields: [
      'childName',
      'guardianName',
      'guardianPhone',
      'age',
      'guardianEmail',
      'specialRequests',
      'upcoming',
      'approved',
    ]);
  }

  Map<String, dynamic> toJsonForPatch() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['childName'] = childName ?? '';
    data['guardianName'] = guardianName ?? '';
    if (guardianPhone != null) {
      final phoneNum = int.tryParse(guardianPhone!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      data['guardianPhone'] = phoneNum;
    } else {
      data['guardianPhone'] = 0;
    }
    data['age'] = age ?? 0;
    data['guardianEmail'] = guardianEmail ?? '';
    data['specialRequests'] = specialRequests ?? '';
    data['upcoming'] = upcoming ?? false;
    data['approved'] = approved ?? false;
    return data;
  }
}