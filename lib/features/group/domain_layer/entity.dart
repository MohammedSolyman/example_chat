import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String groupName;
  String? groupId = '';
  String? groupImage = '';
  String? creationDateTime = '';
  String? adminId = '';
  List<String>? members = [];

  GroupEntity({
    required this.groupName,
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
      ];
}
