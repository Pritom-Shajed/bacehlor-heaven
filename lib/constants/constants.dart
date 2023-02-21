import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Current Date
String currentDate = DateFormat.yMMMd().format(DateTime.now());

//Colors
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color greyColor = Colors.grey;
Color bgColor1 = Color(0xffBEA35E);
Color bgColor2 = Color(0xff7B693B);

Gradient bgColorGradiant = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [bgColor1, bgColor2]);

//Vertical Space
const verticalSpace = Divider(
  color: Colors.transparent,
);

enum Selected { flat, room, seat }
