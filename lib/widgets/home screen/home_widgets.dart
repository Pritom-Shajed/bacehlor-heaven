import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/home%20screen/slider_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AuthController controller = Get.put(AuthController());

// Header
Widget HeaderWidget() {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Bachelor Heaven',
          style: satisfyTextStyle(
              color: blackColor, size: 36, fontWeight: FontWeight.w200)),
      Text(currentDate, style: TextStyle(fontSize: 18)),
      _currentUser == null
          ? Text('Find your next stay...',
              style: poppinsTextStyle(color: greyColor, size: 16))
          : Text('Hi, ${_currentUser.displayName}. Welcome Back!',
              style: poppinsTextStyle(color: greyColor, size: 16)),
    ],
  );
}

// Carousel Slider Items
List<Widget> sliderItems = [
  sliderItemWidget(image: 'assets/category/flat.jpeg', text: 'Flat'),
  sliderItemWidget(image: 'assets/category/room.jpg', text: 'Room'),
  sliderItemWidget(image: 'assets/category/seat.jpg', text: 'Seat'),
];

//Normal Drawer
Widget DrawerWidget(BuildContext context) {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  User? _currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: bgColor),
          child: Center(
            child: Text(
              'Bachelor Heaven',
              style: satisfyTextStyle(size: 36, color: whiteColor),
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Get.toNamed('/login_screen');
            // showModalBottomSheet(
            //   isScrollControlled: true,
            //   context: context,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(12),
            //     ),
            //   ),
            //   builder: (BuildContext context) {
            //     return Padding(
            //       padding: MediaQuery.of(context).viewInsets,
            //       child: SingleChildScrollView(
            //         child: Padding(
            //           padding: EdgeInsets.all(12),
            //           child: bottomSheetWidget(
            //               onTapEmail: () => Get.offNamed('login_screen'),
            //               onTapGoogle: () => controller.signInWithGoogle(
            //                   phoneNumber: _phoneController.text.trim(),
            //                   location: _locationController.text.trim(),
            //                   context: context)),
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
          title: Text('Login'.toUpperCase()),
          subtitle: Text('as user'),
          leading: Icon(Icons.login),
        ),
        ListTile(
          onTap: () => Get.toNamed('/reg_screen'),
          title: Text('New Here ?'.toUpperCase()),
          subtitle: Text('Register'),
          leading: Icon(Icons.app_registration),
        ),
      ],
    ),
  );
}

//Drawer for logged in users
Widget LoggedInDrawer(
    {required String text,
    required String image,
    required BuildContext context}) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: lightGreyColor,
                  backgroundImage: NetworkImage(image)),
              verticalSpace,
              Text(
                text,
                style: poppinsTextStyle(
                    color: whiteColor, size: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () =>Get.toNamed('/my_bookings'),
          title: Text('My Bookings'.toUpperCase()),
          leading: Icon(Icons.add_business),
        ),
        ListTile(
          onTap: () {
            controller.signOut(context);
          },
          title: Text('Sign Out'.toUpperCase()),
          leading: Icon(Icons.logout),
        ),
      ],
    ),
  );
}
