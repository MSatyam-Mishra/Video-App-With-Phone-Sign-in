import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String username;
  String uid;
  String image;

  User({
    required this.name,
    required this.username,
    required this.uid,
    required this.image,
  });

  Map<String, dynamic> toJson() =>
      {"name": name, "username": username, "uid": uid, "image": image};
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        image: snapshot['image']);
  }
}
