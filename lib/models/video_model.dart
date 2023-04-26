import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String name;
  String uid;
  String id;
  List likes;
  List dislikes;
  int commentCount;
  int shareCount;
  String videoTitle;
  String description;
  String category;
  String location;
  String videoURL;
  String thumbnail;
  String profilePhoto;
  final uploadDate;
  List viewCount;
  Video(
      {required this.username,
      required this.name,
      required this.uid,
      required this.id,
      required this.likes,
      required this.uploadDate,
      required this.dislikes,
      required this.commentCount,
      required this.shareCount,
      required this.category,
      required this.description,
      required this.location,
      required this.profilePhoto,
      required this.thumbnail,
      required this.videoTitle,
      required this.videoURL,
      required this.viewCount});
  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "uid": uid,
        "id": id,
        "likes": likes,
        "dislikes": dislikes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "category": category,
        "description": description,
        "location": location,
        "profilePhoto": profilePhoto,
        "thumbnail": thumbnail,
        "videotitle": videoTitle,
        "videoURL": videoURL,
        "viewCount": viewCount,
        "uploadDate": uploadDate,
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        username: snapshot['username'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        dislikes: snapshot['dislikes'],
        commentCount: snapshot['commentCount'],
        shareCount: snapshot['shareCount'],
        category: snapshot['category'],
        description: snapshot['description'],
        location: snapshot['location'],
        profilePhoto: snapshot['profilePhoto'],
        thumbnail: snapshot['thumbnail'],
        videoTitle: snapshot['videotitle'],
        videoURL: snapshot['videoURL'],
        uploadDate: snapshot['uploadDate'],
        viewCount: snapshot['viewCount']);
  }
}
