import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions.dart';
import 'model.dart';

abstract class BaseRemoteGroupDataSource {
  Future<String> createGroup(GroupModel groupModel);
  Future<Unit> updateGroup(GroupModel groupModel);
  Future<Unit> addUsersGroup(List<String> usersIds, String groupId);
  Future<Unit> getAllGroups(void Function(List<GroupModel>) callback);
}

class RemoteGroupDataSource implements BaseRemoteGroupDataSource {
  @override
  Future<String> createGroup(GroupModel groupModel) async {
    try {
      //try to add this group info to the (groups) collection and store
      //its (id) in its information.
      //If it is successful return its id if it is successful,
      //If it is NOT successful throw an server exception

      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('groups info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc();

      docRef.set(groupModel.toMap());
      String groupId = docRef.id;
      docRef.set({'groupId': groupId}, SetOptions(merge: true));

      return groupId;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateGroup(GroupModel groupModel) async {
    try {
      //try to update this group if it fails throw an server exception

      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('groups info');
      DocumentReference<Map<String, dynamic>> docRef =
          colRef.doc(groupModel.groupId);

      await docRef.set(groupModel.toMap(), SetOptions(merge: true));
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addUsersGroup(List<String> usersIds, String groupId) async {
    try {
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('groups info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(groupId);

      DocumentSnapshot<Map<String, dynamic>> docSnap = await docRef.get();
      Map<String, dynamic>? map = docSnap.data();
      GroupModel groupModel = GroupModel.fromMap(map!);
      List<String> members = groupModel.members!;
      List<String> newMembers = [...usersIds, ...members];
      GroupModel newGroupModel = groupModel.copyWith(members: newMembers);
      docRef.set(newGroupModel.toMap());

      return unit;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> getAllGroups(void Function(List<GroupModel>) callback) async {
    List<GroupModel> groups = [];

    try {
      FirebaseFirestore.instance
          .collection('groups info')
          .snapshots()
          .listen((event) {
        List<QueryDocumentSnapshot> docs = event.docs;

        docs.forEach((element) {
          List<dynamic> a = element.get('members');
          List<String> b = a.map((e) => e.toString()).toList();

          GroupModel group = GroupModel(
            groupDescription: element.get('groupDescription'),
            groupName: element.get('groupName'),
            adminId: element.get('adminId'),
            creationDateTime: element.get('creationDateTime'),
            groupId: element.get('groupId'),
            groupImage: element.get('groupImage'),
            members: b,
          );

          groups.add(group);
        });

        //sort all grpoups
        groups.sort(
          (a, b) => a.groupName.compareTo(b.groupName),
        );

        callback(groups);
        groups = [];
      });
      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }
}
