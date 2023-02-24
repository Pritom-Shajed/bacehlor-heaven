import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegScreen extends StatelessWidget {
  RegScreen({super.key});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthController>(builder: (controller) {
      return SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(top: 65),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: bgColor),
              child: Column(
                children: [
                  Text(
                    'Bachelor Heaven',
                    style: satisfyTextStyle(size: 34, color: whiteColor),
                  ),
                  Text(
                    'Welcome!',
                    style: poppinsTextStyle(
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  Text(
                    'Enter your details to continue',
                    style: poppinsTextStyle(size: 12, color: whiteColor),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black38,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        controller.image == null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: lightGreyColor,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'))
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: lightGreyColor,
                                backgroundImage: FileImage(controller.image!)),
                        controller.image == null
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    controller.pickImage(ImageSource.gallery);
                                  },
                                  child: Icon(
                                    Icons.add_circle,
                                  ),
                                ))
                            : Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    controller.pickImage(ImageSource.gallery);
                                  },
                                  child: Icon(
                                    Icons.change_circle,
                                  ),
                                ))
                      ],
                    ),
                    verticalSpace,
                    customTextField(
                        controller: _nameController,
                        hintText: 'Username',
                        icon: Icons.account_box),
                    customTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email),
                    customTextField(
                        obscureText: true,
                        controller: _passController,
                        hintText: 'Password',
                        icon: Icons.lock),
                    customTextField(
                        controller: _locationController,
                        hintText: 'City Name',
                        icon: Icons.location_city),
                    verticalSpace,
                    customButton(
                        text: 'Register',
                        onTap: () {
                          if (controller.image == null) {
                            Fluttertoast.showToast(
                                msg: 'Add your profile photo');
                          } else if (_nameController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter you name');
                          } else if (_emailController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter you email');
                          } else if (_passController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter your password');
                          } else if (_locationController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter your city name');
                          } else {
                            controller.signUp(
                              context: context,
                              email: _emailController.text.toLowerCase().trim(),
                              pass: _passController.text,
                              name: _nameController.text.trim(),
                              location: _locationController.text.trim(),
                            );
                          }
                        }),
                    verticalSpace,
                    Center(
                      child: Text(
                        'Or login using your google account directly',
                        style: poppinsTextStyle(color: greyColor, size: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
