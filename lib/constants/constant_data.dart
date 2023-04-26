import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/controllers/auth_controller.dart';
import 'package:video_share_with_pone_auth/controllers/location_controller.dart';
import 'package:video_share_with_pone_auth/pages/video_screen_page.dart';

import '../pages/add_video_page.dart';

//sign in page variables

TextEditingController countryCodeController = TextEditingController();
var phone = '';
var code = "";

//firebase related instance

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//controllers

var authController = AuthController.instance;

//pages

List pages = [VideoScreenPage(), AddVideoPage(), Text("Profile")];

buildProfile(String profilePhoto) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(60),
    child: Image.network(
      profilePhoto,
      width: 70,
      height: 70,
      fit: BoxFit.cover,
    ),
  );
}

DateTime now = DateTime.now();
// String formattedDate = DateFormat().add_yMMMM().format(now);

// String timeAgo(DateTime d) {
//   Duration diff = DateTime.now().difference(d);
//   if (diff.inDays > 365)
//     return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
//   if (diff.inDays > 30)
//     return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
//   if (diff.inDays > 7)
//     return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
//   if (diff.inDays > 0)
//     return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
//   if (diff.inHours > 0)
//     return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
//   if (diff.inMinutes > 0)
//     return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
//   return "just now";
// }
