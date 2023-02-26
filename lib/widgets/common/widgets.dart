import 'package:bachelor_heaven/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

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
Widget searchBar({
  required TextEditingController controller,
}) {
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

// TextField
Widget customTextField(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false}) {
  return Card(
    elevation: 1,
    child: TextField(
      obscureText: obscureText,
      cursorColor: blackColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        prefixIconColor: blackColor,
        border: InputBorder.none,
      ),
    ),
  );
}

// Custom Button
Widget customButton(
    {required String text,
    required VoidCallback onTap,
    double width = double.maxFinite,
    Alignment alignment = Alignment.center,
    Color color = blackColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: alignment,
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 1,
          color: Colors.black45,
        )
      ], color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: poppinsTextStyle(color: whiteColor, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
