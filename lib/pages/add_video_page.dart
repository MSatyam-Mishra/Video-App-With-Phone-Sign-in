import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/pages/confirm_Video_add_details.dart';

class AddVideoPage extends StatelessWidget {
  const AddVideoPage({super.key});
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmVideoAddDetails(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(children: [
              Icon(
                Icons.image,
                color: primaryColor,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Gallery",
                style: subHeading.copyWith(color: Colors.pink),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(children: [
              Icon(
                Icons.camera_alt,
                color: primaryColor,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Camera",
                style: subHeading.copyWith(color: Colors.pink),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(children: [
              Icon(
                Icons.cancel,
                color: primaryColor,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Cancel",
                style: subHeading.copyWith(color: Colors.pink),
              )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        onTap: () => showOptionDialog(context),
        child: Container(
          child: Container(
              padding: EdgeInsets.all(30),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: primaryColor.withAlpha(20)),
                child: Icon(
                  Icons.add,
                  color: Colors.pink,
                  size: 75,
                ),
              )),
        ),
      ),
    ));
  }
}
