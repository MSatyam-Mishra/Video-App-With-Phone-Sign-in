import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';
import 'package:video_share_with_pone_auth/models/video_model.dart';

class UploadVideocontroller extends GetxController {
  _compressVideo(String videoPath) async {
    final compressdVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressdVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  _getThumbnail(String VideoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(VideoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('Thumbnail').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  uploadVideo(String videoTitle, String description, String category,
      String location, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('video').get();
      int len = allDocs.docs.length;
      String videoURL = await _uploadVideoToStorage('Video $len', videoPath);
      String thumbnail = await _uploadImageToStorage('Video $len', videoPath);
      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)['username'],
          name: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: 'Video $len',
          likes: [],
          dislikes: [],
          commentCount: 0,
          uploadDate: DateTime.now(),
          shareCount: 0,
          category: category,
          description: description,
          location: location,
          viewCount: [],
          profilePhoto: (userDoc.data()! as Map<String, dynamic>)['image'],
          thumbnail: thumbnail,
          videoTitle: videoTitle,
          videoURL: videoURL);
      await firestore.collection('video').doc('Video $len').set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Error! Uploading Video', e.toString());
    }
  }
}
