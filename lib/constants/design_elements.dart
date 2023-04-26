import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

import 'constant_data.dart';

Color secondaryColor = Color(0xFFFFE1EB);
Color primaryColor = Colors.pink;

TextStyle heading = GoogleFonts.nunitoSans(
    fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFFE91E63));

TextStyle subHeading = GoogleFonts.nunitoSans(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

TextStyle bodyText = GoogleFonts.nunitoSans(
    fontSize: 16, fontWeight: FontWeight.normal, color: Colors.pink);

final screenWidth = (ui.window.physicalSize.width / ui.window.devicePixelRatio);
final screenHeight =
    (ui.window.physicalSize.height / ui.window.devicePixelRatio);

class UserInputField extends StatelessWidget {
  UserInputField(
      {required this.textInputType,
      super.key,
      required this.controller,
      this.maxLines = 1,
      required this.hintText,
      required this.inputIcon});

  TextInputType textInputType;
  final hintText;
  Icon inputIcon;
  TextEditingController controller;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          borderRadius: (BorderRadius.circular(15)),
          border: Border.all(width: 0.5, color: Colors.pink)),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            onChanged: (value) {},
            style: bodyText.copyWith(color: Colors.pink),
            decoration: InputDecoration(
                icon: inputIcon,
                iconColor: Colors.pink,
                hintText: hintText,
                fillColor: Colors.pink,
                hintStyle: bodyText.copyWith(color: Color(0xFFE91E63)),
                border: InputBorder.none),
          ))
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({
    required this.textInputType,
    super.key,
    required this.controller,
    this.maxLines = 1,
    required this.hintText,
  });

  TextInputType textInputType;
  final hintText;

  TextEditingController controller;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
          borderRadius: (BorderRadius.circular(15)),
          border: Border.all(width: 0.5, color: Colors.pink)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            onChanged: (value) {},
            style: bodyText.copyWith(color: Colors.pink),
            decoration: InputDecoration(
                iconColor: Colors.pink,
                hintText: hintText,
                fillColor: Colors.pink,
                hintStyle: bodyText.copyWith(color: Color(0xFFE91E63)),
                border: InputBorder.none),
          )),
          Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search,
                color: primaryColor,
              ))
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        width: screenWidth - 30,
        child: SearchBar(
          textInputType: TextInputType.text,
          controller: TextEditingController(),
          hintText: "Search Here",
        ),
      ),
      Container(
          padding: EdgeInsets.only(right: 10),
          width: 30,
          child: Icon(
            Icons.filter_alt,
            color: primaryColor,
          ))
    ]);
  }
}
