import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:video_player/video_player.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/controllers/upload_video_controller.dart';

class ConfirmVideoAddDetails extends StatefulWidget {
  ConfirmVideoAddDetails(
      {super.key, required this.videoFile, required this.videoPath});
  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmVideoAddDetails> createState() => _ConfirmVideoAddDetailsState();
}

class _ConfirmVideoAddDetailsState extends State<ConfirmVideoAddDetails> {
  late VideoPlayerController controller;
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String location = 'Null, Press Button';
  String Address = 'Location';
  String fullAddress = '';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.locality}';
    fullAddress = '${place.street},  ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  UploadVideocontroller uploadVideocontroller =
      Get.put(UploadVideocontroller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight / 1.5,
            child: VideoPlayer(controller),
          ),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth - 20,
                    child: UserInputField(
                        textInputType: TextInputType.text,
                        controller: _titleController,
                        hintText: 'Enter Video Title',
                        inputIcon: Icon(Icons.music_note))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth - 20,
                    child: UserInputField(
                        textInputType: TextInputType.multiline,
                        controller: _descriptionController,
                        hintText: 'Add Description',
                        maxLines: 3,
                        inputIcon: Icon(Icons.closed_caption))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth - 20,
                    child: UserInputField(
                        textInputType: TextInputType.text,
                        controller: _categoryController,
                        hintText: 'Type Video Category',
                        inputIcon: Icon(Icons.category))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: screenWidth - 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: screenWidth * 0.60,
                            padding: EdgeInsets.all(10),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: secondaryColor),
                            child: Center(
                              child: AutoSizeText(
                                '${fullAddress}',
                                maxLines: 3,
                                style: bodyText,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: 0.5,
                                  color: primaryColor,
                                ),
                                backgroundColor: Colors.white,
                                shape: StadiumBorder()),
                            onPressed: () async {
                              Position position =
                                  await _getGeoLocationPosition();
                              location =
                                  'Lat: ${position.latitude} , Long: ${position.longitude}';
                              GetAddressFromLatLong(position);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: screenWidth * 0.15,
                                  child: AutoSizeText(
                                    '${Address}',
                                    style: TextStyle(color: primaryColor),
                                    // overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 20,
                                  child: Icon(
                                    Icons.gps_fixed,
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, shape: StadiumBorder()),
                    onPressed: () => uploadVideocontroller.uploadVideo(
                        _titleController.text,
                        _descriptionController.text,
                        _categoryController.text,
                        Address,
                        widget.videoPath),
                    child: Text(
                      "Add Details",
                      style: subHeading.copyWith(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}
