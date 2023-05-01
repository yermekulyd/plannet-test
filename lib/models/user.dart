import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String photoUrl;

  const User({
    required this.email,
    required this.username,
    this.photoUrl = '',
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "photoUrl": photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
