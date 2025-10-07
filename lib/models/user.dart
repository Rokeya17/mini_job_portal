class UserModel {
  final String email;
  final String name;

  UserModel({required this.email, required this.name});

  Map<String, dynamic> toJson() => {'email': email, 'name': name};

  factory UserModel.fromJson(Map<String, dynamic> m) {
    return UserModel(email: m['email'] ?? '', name: m['name'] ?? '');
  }
}
