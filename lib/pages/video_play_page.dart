import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/controllers/upload_video_controller.dart';
import 'package:video_share_with_pone_auth/pages/video_screen_page.dart';
import 'package:video_share_with_pone_auth/widgets/comment_section.dart';
import 'package:video_share_with_pone_auth/widgets/video_player_item.dart';
import 'package:timeago/timeago.dart' as tago;

import '../controllers/video_controller.dart';

class VideoPlayPage extends StatelessWidget {
  VideoPlayPage({required this.dataVal, required this.indexx});

  final VideoController videoController = Get.put(VideoController());
  var dataVal;
  int indexx;
  final UploadVideocontroller uploadVideocontroller = UploadVideocontroller();
  TextEditingController _replyController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
        ),
        body: SlidingUpPanel(
          borderRadius: BorderRadius.circular(40),
          minHeight: 100,
          maxHeight: screenHeight / 2,
          collapsed: Container(
            height: 50,
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Comments",
              style: heading,
              textAlign: TextAlign.center,
            ),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: Color.fromARGB(255, 243, 236, 236))
          ],
          panel: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: screenHeight,
              width: screenWidth - 20,
              child: CommentSection(
                id: dataVal.id,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: VideoPlayerItem(
                          videoURL: dataVal.videoURL.toString())),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //constraints: BoxConstraints(maxWidth: screenWidth * 0.85),
                    child: Text(
                      dataVal.videoTitle.toString(),
                      softWrap: false,
                      maxLines: 2,
                      style: subHeading,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondaryColor),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  videoController.likeVideo(dataVal.id);
                                },
                                child: Icon(
                                  Icons.thumb_up_outlined,
                                  color: dataVal.likes
                                          .contains(authController.user.uid)
                                      ? primaryColor
                                      : Colors.black,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              dataVal.likes.length.toString(),
                              style: bodyText.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondaryColor),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_down_alt_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              dataVal.dislikes.length.toString(),
                              style: bodyText.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: secondaryColor),
                        child: Row(
                          children: [
                            Icon(Icons.screen_share_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Share",
                              style: bodyText.copyWith(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(dataVal.viewCount.length.toString() + " Views"),
                      Text("  |  "),
                      Text(tago.format(dataVal.uploadDate.toDate())),
                      Text("  |  "),
                      Text(dataVal.category)
                    ],
                  ),
                  Theme(
                    data: theme,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(bottom: 10),
                      title: Text(
                        "Description",
                        style: subHeading,
                      ),
                      children: [
                        ListTile(
                          title: Text(dataVal.description),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              buildProfile(dataVal.profilePhoto),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                dataVal.name,
                                style: heading.copyWith(color: secondaryColor),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "View \nAll Videos",
                          textAlign: TextAlign.center,
                          style: subHeading.copyWith(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )

        // data = videoController.videoList[index];
        );
  }
}
