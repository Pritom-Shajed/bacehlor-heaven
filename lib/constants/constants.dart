import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Current Date
String currentDate = DateFormat.yMMMd().format(DateTime.now());

//Colors
final Color shadowColor = Color(0xFFAFAFAF).withOpacity(0.2);
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color indigoColor = Colors.indigo;
const Color deepBrown = Color(0xff5C4033);
final Color greenColor = Colors.green.shade700;
final Color blueColor = Colors.blue;
const Color greyColor = Colors.grey;
const Color redColor = Colors.red;
const Color amberColor = Colors.amber;
final Color lightGreyColor = Colors.grey.shade300;
final Color bgColor = Colors.black.withOpacity(0.7);

//Vertical Space
const verticalSpace = Divider(
  color: Colors.transparent,
);

const verticalSpaceSmall = SizedBox(
  height: 10,
);

const horizontalSpace = SizedBox(
  width: 10,
);

enum Selected { flat, room, seat }

enum Booking { confirm, pending, cancel }