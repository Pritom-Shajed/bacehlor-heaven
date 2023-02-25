import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

Future<dynamic> editProfileDialog({
  required BuildContext context,
  required String intialName,
  required String initalEmail,
  required String intialLocation,
  // required String imgUrl,
}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: NetworkImage(imgUrl),
                  // ),
                  TextFormField(
                    initialValue: intialName,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  verticalSpace,
                  TextFormField(
                    initialValue: initalEmail,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  verticalSpace,
                  TextFormField(
                    initialValue: intialLocation,
                    decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  verticalSpace,
                  customButton(text: 'Edit', onTap: () {})
                ],
              ),
            )
          ],
        );
      });
}
