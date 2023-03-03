import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Current Date
String currentDate = DateFormat.yMMMd().format(DateTime.now());

//Colors
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color greyColor = Colors.grey;
const Color redColor = Colors.red;
const Color amberColor = Colors.amber;
Color lightGreyColor = Colors.grey.shade300;
Color bgColor = Colors.black.withOpacity(0.7);

//Vertical Space
const verticalSpace = Divider(
  color: Colors.transparent,
);

const horizontalSpace = SizedBox(
  width: 10,
);

enum Selected { flat, room, seat }
