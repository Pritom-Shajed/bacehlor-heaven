import 'package:bachelor_heaven/constants/constants.dart';
import 'package:flutter/material.dart';

Widget emailTextField(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false}) {
  return Card(
    elevation: 1,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field can\'t be empty';
        } else if (!value.contains(RegExp('@'))) {
          return 'Enter a valid email';
        } else {
          return null;
        }
      },
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

Widget userNameTextField(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false}) {
  return Card(
    elevation: 1,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field can\'t be empty';
        } else {
          return null;
        }
      },
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

Widget passTextField(
    {required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = true}) {
  return Card(
    elevation: 1,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field can\'t be empty';
        } else if (value.length < 6) {
          return 'Password must have a minimum of 6 characters';
        } else {
          return null;
        }
      },
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
