class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "";

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        bio = json["bio"];

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
    );
  }
}
