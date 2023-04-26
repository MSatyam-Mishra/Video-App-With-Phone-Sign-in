import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/controllers/video_controller.dart';
import 'package:video_share_with_pone_auth/pages/video_play_page.dart';
import 'package:video_share_with_pone_auth/widgets/search_section.dart';

import '../constants/constant_data.dart';
import 'package:timeago/timeago.dart' as tago;

class VideoScreenPage extends StatelessWidget {
  VideoScreenPage({super.key});
  final VideoController videoController = Get.put(VideoController());

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Searchsection()),
          ),
          child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              width: screenWidth - 30,
              child: Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    borderRadius: (BorderRadius.circular(15)),
                    border: Border.all(width: 0.5, color: Colors.pink)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search Here",
                      style: bodyText,
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: primaryColor,
                        ))
                  ],
                ),
              )),
        ),
        Container(
            padding: EdgeInsets.only(right: 10),
            width: 30,
            child: Icon(
              Icons.filter_alt,
              color: primaryColor,
            ))
      ]),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
              itemCount: videoController.videoList.length,
              controller: ScrollController(
                  initialScrollOffset: 0, keepScrollOffset: true),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = videoController.videoList[index];
                return Container(
                  margin: EdgeInsets.all(5),
                  // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 240, 240),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoPlayPage(
                                    dataVal: videoController.videoList[index],
                                    indexx: videoController.listeners),
                              ),
                            );
                            data.viewCount.add(1);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data.thumbnail,
                              //height: screenHeight / 3,
                              fit: BoxFit.cover,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          buildProfile(data.profilePhoto),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.6),
                                    child: Text(
                                      data.videoTitle.toString(),
                                      softWrap: false,
                                      maxLines: 2,
                                      style: subHeading,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      data.location.toString(),
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    data.name.toString(),
                                    style: bodyText,
                                  ),
                                  Text(" | "),
                                  Text(data.viewCount.length.toString() +
                                      " Views"),
                                  Text(" | "),
                                  Text(
                                    tago.format(data.uploadDate.toDate()),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(" | "),
                                  AutoSizeText(
                                    data.category.toString(),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 5),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              }),
        );
      }),
    );
  }
}
