import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './storage_methods.dart';
import '../models/user_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snapshot);
  }

  //User Sign Up
  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      required String fullname,
      required Uint8List file}) async {
    String result = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          fullname.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String picUrl = await StorageMethods()
            .uploadImageToFirebase("profilePic", file, false);

        //storing extra data in firebase

        model.User user = model.User(
            email: email,
            photoUrl: picUrl,
            followers: [],
            following: [],
            fullName: fullname,
            uid: cred.user!.uid,
            username: username);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        result = "success";
      }
    } on FirebaseAuthException catch (err) {
      result = err.code;
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String result = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "success";
      } else {
        result = "Please enter all Account Details";
      }
    } on FirebaseAuthException catch (error) {
      result = error.code;
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
