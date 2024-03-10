class UserModel {
  String? id;
  String? password;
  String? name;
  final String email;

  UserModel({this.id, this.password, this.name, required this.email});
}
