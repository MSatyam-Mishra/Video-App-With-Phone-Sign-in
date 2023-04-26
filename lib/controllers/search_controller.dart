import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';
import 'package:video_share_with_pone_auth/models/video_model.dart';

class SearchController extends GetxController {
  final Rx<List<Video>> _searchedTitle = Rx<List<Video>>([]);
  List<Video> get searchedTitle => _searchedTitle.value;
  searchTitle(String typedTitle) async {
    _searchedTitle.bindStream(firestore
        .collection('video')
        .where('videotitle', isGreaterThanOrEqualTo: typedTitle)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }
}
