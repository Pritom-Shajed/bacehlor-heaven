import 'package:bachelor_heaven/constants/constants.dart';
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