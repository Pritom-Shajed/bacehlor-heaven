import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

Widget bottomSheetWidget(
    {required VoidCallback onTapEmail, required VoidCallback onTapGoogle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Log in',
        style: poppinsTextStyle(fontWeight: FontWeight.bold, size: 32),
      ),
      Divider(),
      verticalSpace,
      InkWell(
        onTap: onTapGoogle,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: blackColor,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Image.asset('assets/images/google.png'),
                ),
                Text(
                  'Continue with Google',
                  style: poppinsTextStyle(
                      color: blackColor, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      verticalSpace,
      Center(
          child: Text(
        'or',
        style: poppinsTextStyle(fontWeight: FontWeight.w500),
      )),
      verticalSpace,
      InkWell(
        onTap: onTapEmail,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: blackColor,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(
                    'Continue with email',
                    style: poppinsTextStyle(
                        color: blackColor, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ),
      ),
      verticalSpace,
      Center(
        child: Text(
          'By continuing, you agree to our Terms and Conditions',
          style: poppinsTextStyle(color: greyColor, size: 12),
        ),
      ),
    ],
  );
}
