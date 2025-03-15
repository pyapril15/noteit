class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? dob;
  final String? state;
  final String? city;
  final String? profilePhoto;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.dob,
    this.state,
    this.city,
    this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('uid') ||
        !json.containsKey('name') ||
        !json.containsKey('email')) {
      throw ArgumentError('Invalid JSON for UserModel');
    }
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'dob': dob,
      'state': state,
      'city': city,
      'profilePhoto': profilePhoto,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? dob,
    String? state,
    String? city,
    String? profilePhoto,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      state: state ?? this.state,
      city: city ?? this.city,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  String getFullAddress() {
    if (city != null && state != null) {
      return '$city, $state';
    } else if (city != null) {
      return city!;
    } else if (state != null) {
      return state!;
    } else {
      return 'Address not available';
    }
  }
}
