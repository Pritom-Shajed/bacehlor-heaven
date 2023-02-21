import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: 65),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: bgColorGradiant,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            child: Column(
              children: [
                Text(
                  'Bachelor Heaven',
                  style: satisfyTextStyle(size: 34, color: whiteColor),
                ),
                Text(
                  'Login Now',
                  style: poppinsTextStyle(
                      size: 24, fontWeight: FontWeight.bold, color: whiteColor),
                ),
                Text(
                  'We missed you!',
                  style: poppinsTextStyle(size: 12, color: whiteColor),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -320,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding:
                  EdgeInsets.only(top: 15, bottom: 30, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
              ),
              child: Form(
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
                        controller: _emailController,
                        hintText: 'Password',
                        icon: Icons.lock),
                    verticalSpace,
                    customButton(text: 'Sign In', onTap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
