import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_share_with_pone_auth/controllers/search_controller.dart';

import '../constants/design_elements.dart';
import '../controllers/video_controller.dart';
import '../models/video_model.dart';
import '../pages/video_play_page.dart';

class Searchsection extends StatelessWidget {
  Searchsection({
    super.key,
  });

  final SearchController searchController = Get.put(SearchController());
  final VideoController videoController = Get.put(VideoController());
  final myfocuseNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  width: screenWidth - 30,
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(15)),
                        border: Border.all(width: 0.5, color: Colors.pink)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextFormField(
                          focusNode: myfocuseNode,
                          onFieldSubmitted: (value) =>
                              searchController.searchTitle(
                            value,
                          ),
                          maxLines: 1,
                          style: bodyText.copyWith(color: Colors.pink),
                          decoration: InputDecoration(
                              iconColor: Colors.pink,
                              hintText: "Search here",
                              fillColor: Colors.pink,
                              hintStyle:
                                  bodyText.copyWith(color: Color(0xFFE91E63)),
                              border: InputBorder.none),
                        )),
                        InkWell(
                          child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.search,
                                color: primaryColor,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    width: 30,
                    child: Icon(
                      Icons.filter_alt,
                      color: primaryColor,
                    ))
              ]),
          body: searchController.searchedTitle.isEmpty
              ? Center(
                  child: Text("Search Video using title"),
                )
              : ListView.builder(
                  itemCount: searchController.searchedTitle.length,
                  itemBuilder: (context, index) {
                    Video video = searchController.searchedTitle[index];
                    print(video.videoTitle);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPlayPage(
                                dataVal: videoController.videoList[index],
                                indexx: videoController.listeners),
                          ),
                        );
                        video.viewCount.add(1);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 5),
                        child: ListTile(
                          tileColor: Color.fromARGB(255, 250, 236, 236),
                          leading: Container(
                            margin: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(video.thumbnail)),
                          ),
                          title: Text(
                            video.videoTitle,
                            style: subHeading,
                          ),
                        ),
                      ),
                    );
                  }));
    });
  }
}
