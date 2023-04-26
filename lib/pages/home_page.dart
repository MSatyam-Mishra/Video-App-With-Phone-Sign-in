import 'package:flutter/material.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';

import '../constants/design_elements.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: pageIndex == 0
                  ? Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Explore",
                        style: subHeading.copyWith(color: Colors.white),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 225, 235),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Explore",
                        style: subHeading.copyWith(color: Colors.pink),
                      ),
                    ),
              label: ""),
          BottomNavigationBarItem(
              icon: pageIndex == 1
                  ? Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.pink),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 255, 225, 235)),
                      child: Icon(
                        Icons.add,
                        color: Colors.pink,
                        size: 40,
                      ),
                    ),
              label: ""),
          BottomNavigationBarItem(
              icon: pageIndex == 2
                  ? Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Explore",
                        style: subHeading.copyWith(color: Colors.white),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 225, 235),
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        "Library",
                        style: subHeading.copyWith(color: Colors.pink),
                      ),
                    ),
              label: "")
        ],
        type: BottomNavigationBarType.fixed,
      ),
      body: Container(
        child: Center(child: pages[pageIndex]),
      ),
    );
  }
}
