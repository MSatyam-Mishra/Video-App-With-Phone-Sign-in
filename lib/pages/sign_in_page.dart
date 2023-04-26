import 'package:flutter/material.dart';

import '../constants/constant_data.dart';
import '../constants/design_elements.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static String verify = "";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    // TODO: implement initState
    countryCodeController.text = "+91";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.follow_the_signs,
                    color: Colors.pink,
                    size: screenWidth / 2,
                  ),
                  Text(
                    "Login With Your Phone",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: heading.copyWith(color: Colors.pink),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(15)),
                        border: Border.all(width: 0.5, color: Colors.pink)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          width: 40,
                          child: TextField(
                              controller: countryCodeController,
                              style: bodyText.copyWith(color: Colors.pink),
                              decoration: InputDecoration(
                                  hintText: "+91",
                                  fillColor: Colors.pink,
                                  hintStyle: bodyText.copyWith(
                                      color: Color(0xFFE91E63)),
                                  border: InputBorder.none)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 0.5,
                          height: 25,
                          color: Colors.pink,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          style: bodyText.copyWith(color: Colors.pink),
                          decoration: InputDecoration(
                              hintText: "Enter Your Phone",
                              fillColor: Colors.pink,
                              hintStyle:
                                  bodyText.copyWith(color: Color(0xFFE91E63)),
                              border: InputBorder.none),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  UniversalButton(
                    screenWidth: screenWidth,
                    onPressed: () async {
                      authController.sendOTP();
                    },
                    btnText: "Send OTP",
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class UniversalButton extends StatelessWidget {
  const UniversalButton(
      {super.key,
      required this.screenWidth,
      required this.btnText,
      required this.onPressed});

  final double screenWidth;
  final String btnText;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 60,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPressed,
          child: Text(
            btnText,
            style: subHeading.copyWith(color: Colors.white),
          )),
    );
  }
}
