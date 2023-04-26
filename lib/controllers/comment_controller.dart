import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';

import '../models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = "";
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(firestore
        .collection('video')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(Comment.fromSnap(element));
      }
      return retvalue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await firestore
            .collection('video')
            .doc('_postId')
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        Comment comment = Comment(
            name: (userDoc.data() as dynamic)['name'],
            comment: commentText.trim(),
            datePublished: DateTime.now(),
            id: 'Comment $len',
            likes: [],
            profilePhoto: (userDoc.data() as dynamic)['image'],
            uid: authController.user.uid);
        await firestore
            .collection('video')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firestore.collection('video').doc(_postId).get();
        await firestore.collection('video').doc(_postId).update(
            {'commentCount': (doc.data() as dynamic)['commentCount'] + 1});
      }
    } catch (e) {
      Get.snackbar('Error while Posting commnet!', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('video')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('video')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('video')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
