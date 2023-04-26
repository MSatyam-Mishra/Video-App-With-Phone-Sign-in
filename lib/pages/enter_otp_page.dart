import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import '../constants/constant_data.dart';
import '../constants/design_elements.dart';

class OTPPage extends StatefulWidget {
  OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Colors.pink, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 252, 179, 203)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.pink),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromARGB(255, 255, 224, 234),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.pink,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                    size: screenWidth / 2,
                    color: Colors.pink,
                  ),
                  Text(
                    "Enter Your One Time Password",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: heading.copyWith(color: Colors.pink),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onChanged: (value) {
                      code = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: screenWidth - 60,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () async {
                          authController.verifyOTP();
                        },
                        child: Text(
                          "Verify Phone Number",
                          style: subHeading.copyWith(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'signinpage', (route) => false);
                    },
                    child: Text(
                      "Edit Your Phone Number",
                      style: subHeading.copyWith(
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
