import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? id;
  String? password;
  String? name;
  String? image;
  final String email;
  List<String> subscribedGroupsIds = [];

  UserEntity({
    this.id,
    this.password,
    this.name,
    this.image,
    required this.email,
    required this.subscribedGroupsIds,
  });

  @override
  List<Object> get props {
    return [
      email,
      subscribedGroupsIds,
    ];
  }
}
