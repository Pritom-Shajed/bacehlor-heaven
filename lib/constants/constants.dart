import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Current Date
String currentDate = DateFormat.yMMMd().format(DateTime.now());

//Colors
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color greyColor = Colors.grey;

//Vertical Space
const verticalSpace = Divider(
  color: Colors.transparent,
);

enum Selected { flat, room, seat }
