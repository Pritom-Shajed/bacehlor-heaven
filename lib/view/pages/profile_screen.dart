import 'dart:math';

import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    'My Profile',
                    style: poppinsTextStyle(
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 170,
              bottom: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: lightGreyColor,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      verticalSpace,
                      Text(
                        'Pritom Shajed',
                        style: poppinsTextStyle(
                            size: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Joined: $currentDate',
                        style: poppinsTextStyle(
                            color: greyColor,
                            size: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      verticalSpace,
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email:',
                              style:
                                  poppinsTextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'pritomshajed@gmail.com',
                              style: poppinsTextStyle(size: 15),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace,
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location:',
                              style:
                                  poppinsTextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Dhaka',
                              style: poppinsTextStyle(size: 15),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace,
                      Container(
                          child: customButton(
                              text: 'Edit',
                              onTap: () {
                                print('edit');
                              })),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
