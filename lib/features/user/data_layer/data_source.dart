import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_cli_test/features/user/data_layer/model.dart';

import '../../../core/errors/exceptions.dart';

abstract class BaseRemoteUserDataSource {
  //iAuthentication
  Future<String> signUp(UserModel userModel);
  Future<String> signIn(UserModel userModel);
  Future<Unit> signOut(UserModel userModel);

  //interactions with (contacts info collection)
  Future<Unit> addUserToContactInfo(UserModel userModel);
  Future<Unit> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserModel>) callback);

  //interactions with groups
  Future<List<UserModel>> addUsersToGroup(
      List<UserModel> usersModels, String groupId);
  Future<Unit> deleteUserFromGroup(UserModel userModel, String groupId);
}

class RemoteUserDataSource implements BaseRemoteUserDataSource {
  @override
  Future<String> signIn(UserModel userModel) async {
    try {
      //try to sign in this user to firebase auth,
      //if it NOT successful throw the corresponding exceptions.

      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw NotFoundExeption();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordExeption();
      } else if (e.code == 'invalid-credential') {
        throw InvalidCredentialExeption();
      } else {
        throw UnkownException();
      }
    }
  }

  @override
  Future<String> signUp(UserModel userModel) async {
    try {
      //try to register this user to firebase auth
      //if it is successful, return the id of the user.
      //if it NOT successful throw the corresponding exceptions.

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw AlreadySingedUpException();
      } else {
        throw UnkownException();
      }
    }
  }

  @override
  Future<Unit> signOut(UserModel userModel) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

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
      String currentUserId, void Function(List<UserModel>) callback) async {
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
          if (currentUserId != element.get('id')) {
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
  Future<List<UserModel>> addUsersToGroup(
      List<UserModel> usersModels, String groupId) {
    // TODO: implement addUsersToGroup
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteUserFromGroup(UserModel userModel, String groupId) {
    // TODO: implement deleteUserFromGroup
    throw UnimplementedError();
  }

  @override
  List<UserModel> users = [];
}


// a -> c