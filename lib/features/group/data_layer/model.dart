import 'package:my_cli_test/features/group/domain_layer/entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    required super.groupName,
    super.members,
    super.groupImage,
    super.creationDateTime,
    super.adminId,
    super.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupName': groupName,
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
        members: groupEntity.members,
        adminId: groupEntity.adminId,
        groupId: groupEntity.groupId,
        creationDateTime: groupEntity.creationDateTime,
        groupImage: groupEntity.groupImage);
  }
}
