import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/widgets/bottom%20sheet/bottom_scheet_widget.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/home%20screen/gridItems.dart';
import 'package:bachelor_heaven/widgets/home%20screen/slider_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AuthController controller = Get.put(AuthController());

// Header
Widget HeaderWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Bachelor Heaven',
          style: satisfyTextStyle(
              color: blackColor, size: 36, fontWeight: FontWeight.w200)),
      Text(currentDate, style: TextStyle(fontSize: 18)),
      Text('Find your next stay...',
          style: poppinsTextStyle(color: greyColor, size: 16)),
    ],
  );
}

// Carousel Slider Items
List<Widget> items = [
  sliderItem(
      imageUrl:
          'https://paarthinfrablog.files.wordpress.com/2019/08/multistorey-apartment-flat-for-sale.jpeg',
      text: 'Flat'),
  sliderItem(
      imageUrl:
          'https://www.rd.com/wp-content/uploads/2021/03/GettyImages-1207490255-e1615485559611.jpg',
      text: 'Room'),
  sliderItem(
      imageUrl:
          'https://cdn.kiit.ac.in/wp-content/uploads/2022/03/KIIT-Hostel-3-Sharing.jpg',
      text: 'Seat')
];

//Grid Items
List<Widget> gridItems = [
  gridItem(
      imageUrl:
          'https://paarthinfrablog.files.wordpress.com/2019/08/multistorey-apartment-flat-for-sale.jpeg',
      text: 'Flat'),
  gridItem(
      imageUrl:
          'https://www.rd.com/wp-content/uploads/2021/03/GettyImages-1207490255-e1615485559611.jpg',
      text: 'Room'),
  gridItem(
      imageUrl:
          'https://cdn.kiit.ac.in/wp-content/uploads/2022/03/KIIT-Hostel-3-Sharing.jpg',
      text: 'Seat')
];

//Normal Drawer
Widget DrawerWidget(BuildContext context) {
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
            Get.back();
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              builder: (BuildContext context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: bottomSheetWidget(
                          onTapEmail: () => Get.offNamed('login_screen'),
                          onTapGoogle: () {}),
                    ),
                  ),
                );
              },
            );
          },
          title: Text('Login'.toUpperCase()),
          subtitle: Text('as landlord'),
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
Widget LoggedInDrawer({required String text}) {
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
                  backgroundImage: AssetImage('assets/images/avatar.png')),
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
          onTap: () {
            controller.signOut();
          },
          title: Text('Sign Out'.toUpperCase()),
          leading: Icon(Icons.logout),
        ),
      ],
    ),
  );
}
