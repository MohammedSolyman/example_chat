import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/errors/exceptions.dart';
import 'model.dart';

abstract class BaseRemoteUserDataSource {
  //iAuthentication
  Future<UserModel> signUp(UserModel userModel);
  Future<String> signIn(UserModel userModel);
  Future<Unit> signOut(UserModel userModel);

  //interactions with (contacts info collection)
  Future<Unit> addUserToContactInfo(UserModel userModel);
  Future<Unit> getUsersFromCantactsInfo(
      String currentUserId, void Function(List<UserModel>) callback);
  Future<UserModel> getUserInfo(String userId);

  //interactions with groups
  Future<Unit> addGroupToUser(UserModel userModel, String groupId);
  Future<Unit> deleteGroupFromUser(UserModel userModel, String groupId);
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
  Future<UserModel> signUp(UserModel userModel) async {
    try {
      //try to register this user to firebase auth
      //if it is successful, return the model of the user.
      //if it NOT successful throw the corresponding exceptions.

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);

      UserModel createdUser = userModel.copyWith(id: credential.user!.uid);
      return createdUser;
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
  Future<Unit> addGroupToUser(UserModel userModel, String groupId) async {
    try {
      //try to update this user in the (contacts info) collection
//if it fails, throw an exception
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('contacts info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(userModel.id);
      await docRef.set(userModel.toMap(), SetOptions(merge: true));
      return unit;
    } catch (e) {
      throw UnkownException();
    }
  }

  @override
  Future<UserModel> getUserInfo(String userId) async {
    try {
      //try to get this user info from (contacts info) collection

//if fails throw an exception
      FirebaseFirestore myInstance = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> colRef =
          myInstance.collection('contacts info');
      DocumentReference<Map<String, dynamic>> docRef = colRef.doc(userId);

      DocumentSnapshot<Map<String, dynamic>> docSnap = await docRef.get();
      Map<String, dynamic>? map = docSnap.data();
      UserModel user = UserModel.fromMap(map!);

      return user;
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
