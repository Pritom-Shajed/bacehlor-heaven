import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/home%20screen/gridItems.dart';
import 'package:bachelor_heaven/widgets/home%20screen/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Header
Widget HeaderWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Bachelor Heaven',
          style: satisfyTextStyle(
              color: blackColor, size: 36, fontWeight: FontWeight.w200)),
      Text(currentDate, style: TextStyle(fontSize: 18)),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Hello, ',
            style: poppinsTextStyle(color: greyColor, size: 16)),
        TextSpan(
            text: 'Pritom Shajed',
            style: poppinsTextStyle(color: greyColor, size: 16)),
      ])),
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

Widget DrawerWidget() {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(gradient: bgColorGradiant),
          child: Center(
            child: Text(
              'Bachelor Heaven',
              style: satisfyTextStyle(size: 36, color: whiteColor),
            ),
          ),
        ),
        ListTile(
          title: Text('Sign In'.toUpperCase()),
          subtitle: Text('as user'),
          leading: Icon(Icons.login),
        ),
        ListTile(
          onTap: () => Get.toNamed('/login_screen'),
          title: Text('Sign In'.toUpperCase()),
          subtitle: Text('as landlord'),
          leading: Icon(Icons.login),
        ),
        ListTile(
          title: Text('New Here ?'.toUpperCase()),
          subtitle: Text('Register'),
          leading: Icon(Icons.app_registration),
        ),
      ],
    ),
  );
}
