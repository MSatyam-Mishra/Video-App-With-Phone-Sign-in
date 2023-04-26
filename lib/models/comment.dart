import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String name;
  String comment;
  final datePublished;
  List likes;
  String uid;
  String id;
  String profilePhoto;
  Comment(
      {required this.name,
      required this.comment,
      required this.datePublished,
      required this.id,
      required this.likes,
      required this.profilePhoto,
      required this.uid});
  Map<String, dynamic> toJson() => {
        'name': name,
        'comment': comment,
        'datePublished': datePublished,
        'id': id,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid
      };
  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        name: snapshot['name'],
        comment: snapshot['comment'],
        datePublished: snapshot['datePublished'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid']);
  }
}
