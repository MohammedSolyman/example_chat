import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/models/user_model.dart';

abstract class BaseRemoteUserDataSource {
  //interactions with (contacts info collection)
  Future<Unit> addUserToContactInfo(UserModel userModel);
  Future<Unit> getUsersFromCantactsInfo(
      String userId, void Function(List<UserModel>) callback);

  //interactions with groups
  Future<Unit> addGroupToUser(UserModel userModel, String groupId);
  Future<Unit> deleteGroupFromUser(UserModel userModel, String groupId);
}

class RemoteUserDataSource implements BaseRemoteUserDataSource {
  @override
  Future<Unit> addUserToContactInfo(UserModel userModel) async {
    try {
      //try to add this user to the (contacts info) collection
      //in the firebase and assign the user id as a document name.
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('contacts info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(userModel.id);
      await docRef.set(userModel.toMap());
      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }

  @override
  Future<Unit> getUsersFromCantactsInfo(
      String userId, void Function(List<UserModel>) callback) async {
    // try to get a list of all users
    //If it is successful sort the list alphebetically and retun it..
    //If it is NOT seccessfult throw an expception.

    try {
      List<UserModel> users = [];

      FirebaseFirestore.instance
          .collection("contacts info")
          .snapshots()
          .listen((event) {
        List<QueryDocumentSnapshot> docs = event.docs;

        docs.forEach((element) {
          if (userId != element.get('id')) {
            UserModel user = UserModel(
                id: element.get('id'),
                name: element.get('name'),
                email: element.get('email'),
                subscribedGroupsIds: const []);

            users.add(user);
          }
        });

        users.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        callback(users);
        users = [];
      });

      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }

  @override
  Future<Unit> addGroupToUser(UserModel userModel, String groupId) async {
    try {
      //try to update this user in the (contacts info) collection
//if it fails, throw an exception
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('contacts info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(userModel.id);
      await docRef.set(userModel.toMap());

      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }

  @override
  Future<Unit> deleteGroupFromUser(UserModel userModel, String groupId) {
    // TODO: implement deleteGroupFromUser
    throw UnimplementedError();
  }
}
