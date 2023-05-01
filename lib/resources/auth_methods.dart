import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return model.User.fromSnap(snap);
  }

  // Sign Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        // Register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        // Add User to Database
        model.User user = model.User(
          email: email,
          username: username,
          photoUrl: photoUrl,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred!";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signOutUser() async {
    String res = "Some error occurred!";

    try {
      await _auth.signOut();
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
