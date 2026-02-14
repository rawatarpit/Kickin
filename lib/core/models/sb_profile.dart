class SbProfile {
  final String firebaseUid;
  final String name;
  final String? email;
  final DateTime dob;
  final String userType;
  final String? profileImageUrl;

  SbProfile({
    required this.firebaseUid,
    required this.name,
    required this.dob,
    required this.userType,
    this.email,
    this.profileImageUrl,
  });

  /// 🔹 Convert Supabase row → Model
  factory SbProfile.fromMap(Map<String, dynamic> map) {
    return SbProfile(
      firebaseUid: map['firebase_uid'],
      name: map['name'],
      email: map['email'],
      dob: DateTime.parse(map['dob']),
      userType: map['user_type'],
      profileImageUrl: map['profile_image'],
    );
  }

  /// 🔹 Convert Model → Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      'firebase_uid': firebaseUid,
      'name': name,
      'email': email,
      'dob': dob.toIso8601String(),
      'user_type': userType,
      'profile_image': profileImageUrl,
      'profile_completed': true,
    };
  }
}
