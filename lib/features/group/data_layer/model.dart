import '../domain_layer/entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    required super.groupName,
    required super.groupDescription,
    super.members,
    super.groupImage,
    super.creationDateTime,
    super.adminId,
    super.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupName': groupName,
      'groupDescription': groupDescription,
      'members': members,
      'groupId': groupId,
      'groupImage': groupImage,
      'creationDateTime': creationDateTime,
      'adminId': adminId,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      groupName: map['groupName'],
      groupDescription: map['groupDescription'],
      members: List<String>.from((map['members'])),
      groupId: map['groupId'],
      groupImage: map['groupImage'],
      creationDateTime: map['creationDateTime'],
      adminId: map['adminId'],
    );
  }

  factory GroupModel.fromEntity(GroupEntity groupEntity) {
    return GroupModel(
        groupName: groupEntity.groupName,
        groupDescription: groupEntity.groupDescription,
        members: groupEntity.members,
        adminId: groupEntity.adminId,
        groupId: groupEntity.groupId,
        creationDateTime: groupEntity.creationDateTime,
        groupImage: groupEntity.groupImage);
  }

  GroupModel copyWith({
    String? groupName,
    String? groupDescription,
    String? groupId,
    String? groupImage,
    int? creationDateTime,
    String? adminId,
    List<String>? members,
  }) {
    return GroupModel(
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      groupId: groupId ?? this.groupId,
      groupImage: groupImage ?? this.groupImage,
      creationDateTime: creationDateTime ?? this.creationDateTime,
      adminId: adminId ?? this.adminId,
      members: members ?? this.members,
    );
  }
}
