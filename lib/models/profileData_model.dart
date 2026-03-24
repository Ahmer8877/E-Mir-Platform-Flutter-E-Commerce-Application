class UserModel {
  final String name;
  final String email;
  final String password;
  final String photoUrl;
  final String createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.photoUrl,
    required this.createdAt,
  });
}