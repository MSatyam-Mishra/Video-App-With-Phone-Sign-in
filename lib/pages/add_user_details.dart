import 'package:flutter/material.dart';

import 'package:video_share_with_pone_auth/constants/constant_data.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';

import 'package:video_share_with_pone_auth/pages/sign_in_page.dart';

class AddUserDetails extends StatefulWidget {
  const AddUserDetails({super.key});

  @override
  State<AddUserDetails> createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User Details",
                maxLines: 2,
                style:
                    heading.copyWith(fontSize: 45, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              UserImage(),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 15,
              ),
              UserInputField(
                  controller: _usernameController,
                  textInputType: TextInputType.text,
                  hintText: "Enter Username",
                  inputIcon: Icon(Icons.verified_user_rounded)),
              SizedBox(
                height: 15,
              ),
              UserInputField(
                controller: _nameController,
                hintText: "Enter Your Name",
                inputIcon: Icon(Icons.people),
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              UniversalButton(
                screenWidth: screenWidth,
                btnText: "Save Details",
                onPressed: () async {
                  authController.addUserDetails(_usernameController.text,
                      _nameController.text, authController.profilePhoto);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
      child: Container(
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.pink.shade50),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
          child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pink.shade50),
              child: InkWell(
                onTap: () => authController.pickImage(),
                child: Icon(
                  Icons.camera_alt,
                  size: screenWidth / 6,
                  color: Colors.pink,
                ),
              )),
        ),
      ),
    );
  }
}
