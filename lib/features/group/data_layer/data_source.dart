import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_cli_test/core/errors/exceptions.dart';
import 'package:my_cli_test/features/group/data_layer/model.dart';

abstract class BaseRemoteGroupDataSource {
  Future<String> createGroup(GroupModel groupModel);
  Future<Unit> updateGroup(GroupModel groupModel);
  Future<Unit> addUsersGroup(List<String> usersIds, String groupId);
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
}
