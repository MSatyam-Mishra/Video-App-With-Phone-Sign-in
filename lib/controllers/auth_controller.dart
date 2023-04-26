import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_share_with_pone_auth/models/user_maodel.dart' as model;
import 'package:video_share_with_pone_auth/pages/add_user_details.dart';
import 'package:video_share_with_pone_auth/pages/enter_otp_page.dart';
import 'package:video_share_with_pone_auth/pages/home_page.dart';

import '../constants/constant_data.dart';
import '../pages/sign_in_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          "Profile Picture", "You have successfully Selected Profile Pic");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SignInPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  //function to send otp
  sendOTP() async {
    String phoneNumber = countryCodeController.text + phone;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException e) {
          print('Failed to verify phone number: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('OTP sent: $verificationId');
          SignInPage.verify = verificationId;
          Get.off(OTPPage());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('OTP auto retrieval timeout: $verificationId');
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: SignInPage.verify, smsCode: code);
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        Get.offAll(() => AddUserDetails());
      } else {
        Get.offAll(() => HomePage());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> _uploadToFirebase(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  void addUserDetails(String username, String name, File? image) async {
    try {
      if (username.isNotEmpty && name.isNotEmpty && image != null) {
        //add some functionality to add username and name in firestore
        String downloadURL = await _uploadToFirebase(image);
        model.User user = model.User(
            name: name,
            username: username,
            uid: firebaseAuth.currentUser!.uid,
            image: downloadURL);
        await firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .set(user.toJson());
        Get.off(HomePage());
      } else {
        Get.snackbar('Error Adding user Details', e.toString());
      }
    } catch (e) {
      Get.snackbar('Error Adding user Details', e.toString());
    }
  }
}
