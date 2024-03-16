import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/models/user_model.dart';

abstract class BaseRemoteAuthDataSource {
  Future<UserModel> signUp(UserModel userModel);
  Future<String> signIn(UserModel userModel);
  Future<Unit> signOut();
  Future<UserModel> getUserInfo(String userId);
}

class RemoteAuthDataSource implements BaseRemoteAuthDataSource {
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
  Future<Unit> signOut() async {
    try {
      //try to sign out this user.
      //if it NOT successful throw the corresponding exceptions.

      await FirebaseAuth.instance.signOut();
      return unit;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
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
}
