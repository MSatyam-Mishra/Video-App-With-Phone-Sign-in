import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';

import '../models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(
        firestore.collection('video').snapshots().map((QuerySnapshot query) {
      List<Video> returnValue = [];
      for (var element in query.docs) {
        returnValue.add(Video.fromSnap(element));
      }
      return returnValue;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('video').doc(id).get();
    var uid = authController.user.uid;

    var data = doc.data();
    if (data != null && (data as dynamic)['likes'].contains(uid)) {
      await firestore.collection('video').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('video').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
