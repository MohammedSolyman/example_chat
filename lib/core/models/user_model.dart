import '../entities/user_entitie.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.subscribedGroupsIds,
    required super.email,
    super.id,
    super.password,
    super.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'password': password,
      'name': name,
      'email': email,
      'subscribedGroupsIds': subscribedGroupsIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        password: map['password'],
        name: map['name'],
        email: map['email'],
        subscribedGroupsIds: List<String>.from(
          (map['subscribedGroupsIds']),
        ));
  }

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
      subscribedGroupsIds: userEntity.subscribedGroupsIds,
      email: userEntity.email,
      id: userEntity.id,
      name: userEntity.name,
      password: userEntity.password);

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        password: password,
        email: email,
        subscribedGroupsIds: subscribedGroupsIds,
      );

  UserModel copyWith({
    String? id,
    String? password,
    String? name,
    String? email,
    List<String>? subscribedGroupsIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      subscribedGroupsIds: subscribedGroupsIds ?? this.subscribedGroupsIds,
    );
  }
}
