class InvitationItem {
  int? id;
  String? childName;
  String? guardianPhone;
  int? age;
  String? guardianEmail;
  String? specialRequests;
  String? address;
  String? date;
  String? time;
  bool? upcoming;
  bool? approved;

  InvitationItem({
    this.id,
    this.childName,
    this.guardianPhone,
    this.age,
    this.guardianEmail,
    this.specialRequests,
    this.address,
    this.date,
    this.time,
    this.upcoming,
    this.approved,
  });

  InvitationItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    childName = json['childName'] as String?;
    guardianPhone = json['guardianPhone']?.toString();
    age = json['age'] as int?;
    guardianEmail = json['guardianEmail'] as String?;
    specialRequests = json['specialRequests'] as String?;
    address = json['address'] as String?;
    date = json['date'] as String?;
    time = json['time']?.toString();
    upcoming = json['upcoming'] as bool?;
    approved = json['approved'] as bool?;
  }

  Map<String, dynamic> toJson({List<String> includeFields = const []}) {
    final Map<String, dynamic> data = {};
    final fields = includeFields.isEmpty
        ? [
      'id',
      'childName',
      'guardianPhone',
      'age',
      'guardianEmail',
      'specialRequests',
      'address',
      'date',
      'time',
      'upcoming',
      'approved',
    ]
        : includeFields;

    if (fields.contains('id') && id != null) data['id'] = id;
    if (fields.contains('childName') && childName != null) data['childName'] = childName;
    if (fields.contains('guardianPhone') && guardianPhone != null) {
      final phoneNum = int.tryParse(guardianPhone!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      data['guardianPhone'] = phoneNum;
    }
    if (fields.contains('age') && age != null) data['age'] = age;
    if (fields.contains('guardianEmail') && guardianEmail != null) data['guardianEmail'] = guardianEmail;
    if (fields.contains('specialRequests') && specialRequests != null) data['specialRequests'] = specialRequests;
    if (fields.contains('address') && address != null) data['address'] = address;
    if (fields.contains('date') && date != null) data['date'] = date;
    if (fields.contains('time') && time != null) {
      final timeNum = int.tryParse(time!) ?? 0;
      data['time'] = timeNum;
    }
    if (fields.contains('upcoming') && upcoming != null) data['upcoming'] = upcoming;
    if (fields.contains('approved') && approved != null) data['approved'] = approved;

    return data;
  }

  Map<String, dynamic> toJsonForCreate() {
    return toJson(includeFields: [
      'childName',
      'guardianPhone',
      'age',
      'guardianEmail',
      'specialRequests',
      'address',
      'date',
      'time',
      'upcoming',
      'approved',
    ]);
  }

  Map<String, dynamic> toJsonForPatch() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    data['childName'] = childName ?? '';
    if (guardianPhone != null) {
      final phoneNum = int.tryParse(guardianPhone!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    data['guardianPhone'] = phoneNum;
    } else {
    data['guardianPhone'] = 0;
    }
    data['age'] = age ?? 0;
    data['guardianEmail'] = guardianEmail ?? '';
    data['specialRequests'] = specialRequests ?? '';
    data['address'] = address ?? '';
    data['date'] = date ?? '';
    if (time != null) {
    final timeNum = int.tryParse(time!) ?? 0;
    data['time'] = timeNum;
    } else {
    data['time'] = 0;
    }
    data['upcoming'] = upcoming ?? false;
    data['approved'] = approved ?? false;
    return data;
  }
}