import 'package:bachelor_heaven/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//TextStyle
TextStyle poppinsTextStyle({
  Color? color,
  double? size,
  FontWeight? fontWeight,
  double? letterSpacing,
}) =>
    GoogleFonts.poppins(
        textStyle: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    ));

TextStyle satisfyTextStyle({
  Color? color,
  double? size,
  FontWeight? fontWeight,
  double? letterSpacing,
}) =>
    GoogleFonts.greatVibes(
        textStyle: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    ));



//Search Bar
Widget searchBar({required TextEditingController controller, }){
  return Card(
    elevation: 3,
    child: TextField(
      cursorColor: blackColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search your desired place...',
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Colors.grey.shade700,
        border: InputBorder.none,
      ),
    ),
  );
}
