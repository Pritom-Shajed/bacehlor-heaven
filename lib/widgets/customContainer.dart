import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

Widget customContainer({required Widget child,  EdgeInsetsGeometry? margin,  EdgeInsetsGeometry? padding}){
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.circular(12)
    ),
    child: child,
  );
}

Widget customContainer2({required String text,
  double width = double.maxFinite,
  Alignment alignment = Alignment.center,
  Color color = blackColor}) {
  return Container(
    alignment: alignment,
    width: width,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        blurRadius: 1,
        color: Colors.black45,
      )
    ], color: color, borderRadius: BorderRadius.circular(16)),
    child: Text(
      text,
      style: poppinsTextStyle(color: whiteColor, fontWeight: FontWeight.w500),
    ),
  );
}