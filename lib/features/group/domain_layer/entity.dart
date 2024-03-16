import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  String groupName;
  String groupDescription;
  String? groupId = '';
  String? groupImage = '';
  int? creationDateTime;
  String? adminId = '';
  List<String>? members = [];

  GroupEntity({
    required this.groupName,
    required this.groupDescription,
    this.members,
    this.groupId,
    this.groupImage,
    this.creationDateTime,
    this.adminId,
  });

  @override
  List<Object?> get props => [
        groupImage,
        groupName,
        groupId,
        creationDateTime,
        adminId,
        members,
        groupDescription
      ];
}
