class UserModel {
  final String? id;
  final String? password;
  final String name;
  final String email;

  UserModel({this.id, this.password, required this.name, required this.email});
}
