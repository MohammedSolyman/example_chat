import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_cli_test/core/errors/exceptions.dart';
import 'package:my_cli_test/features/group/data_layer/model.dart';

abstract class BaseRemoteGroupDataSource {
  Future<String> createGroup(GroupModel groupModel);
  Future<Unit> renameGroup(GroupModel groupModel);
}

class RemotePostDataSource implements BaseRemoteGroupDataSource {
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
  Future<Unit> renameGroup(GroupModel groupModel) async {
    try {
      //try to rename this group if it fails throw an server exception

      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('groups info');
      DocumentReference<Map<String, dynamic>> docRef =
          colRef.doc(groupModel.groupId);

      await docRef.set({'groupName': 'new name'}, SetOptions(merge: true));
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }
}
