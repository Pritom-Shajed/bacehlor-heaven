import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/home%20screen/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Shimmer Effect
Widget ShimmerEffect({required double height, required double width}) {
  return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: blackColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16)));
}

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
  required Function(String) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      shadowColor: shadowColor,
      child: TextField(
        controller: controller,
        cursorColor: blackColor,
        decoration: InputDecoration(
          hintText: 'Search by your location...',
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.grey.shade700,
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    ),
  );
}

// TextField
Widget customTextField({required TextEditingController controller,
  required String hintText,
  required IconData icon,
  IconData? suffixIcon,
  VoidCallback? suffixIconTap,
  int? maxLines,
  bool obscureText = false,
  TextInputType inputType = TextInputType.text}) {
  return Card(
    elevation: 1,
    child: TextField(
      maxLines: maxLines,
      keyboardType: inputType,
      obscureText: obscureText,
      cursorColor: blackColor,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(onTap: suffixIconTap, child: Icon(suffixIcon, color: greyColor,)),
        hintText: hintText,
        prefixIcon: Icon(icon),
        prefixIconColor: blackColor,
        border: InputBorder.none,
      ),
    ),
  );
}

// Custom Button
Widget customButton({required String text,
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
      ], color: color, borderRadius: BorderRadius.circular(16)),
      child: Text(
        text,
        style: poppinsTextStyle(color: whiteColor, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
