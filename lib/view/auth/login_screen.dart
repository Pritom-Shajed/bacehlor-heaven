import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (controller) {
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
                      'Login Now',
                      style: poppinsTextStyle(
                          size: 24,
                          fontWeight: FontWeight.bold,
                          color: whiteColor),
                    ),
                    Text(
                      'We missed you!',
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
                      SizedBox(
                        width: 160,
                        child: Image.asset('assets/images/sign-in.png'),
                      ),
                      customTextField(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icons.email),
                      customTextField(
                          obscureText: true,
                          controller: _passController,
                          hintText: 'Password',
                          icon: Icons.lock),
                      verticalSpace,
                      customButton(
                          text: 'Login',
                          onTap: () {
                            controller.singIn(
                                context: context,
                                email: _emailController.text,
                                pass: _passController.text);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
