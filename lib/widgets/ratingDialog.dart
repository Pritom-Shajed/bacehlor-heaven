import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/booking/rating_controller.dart';

import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

RatingController _ratingController = Get.put(RatingController());

Widget RatingDialog(
    {required TextEditingController ratingTextController, required String apartmentUid, required String comments, required String time, required BuildContext context, required String ratedBy}) {
  return SimpleDialog(
    children: [
      Center(child: Text('How you liked your stay?',
        style: poppinsTextStyle(fontWeight: FontWeight.w500),)),
      verticalSpace,
      Center(
        child: RatingBar.builder(
          initialRating: _ratingController.rating.value,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: (rating) {
            _ratingController.updateRating(rating);
          },
        ),
      ),
      TextField(controller: ratingTextController,
        cursorColor: bgColor,
        decoration: InputDecoration(
          hintText: 'Comments',
          prefixIcon: Icon(Icons.comment, color: greyColor,),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: bgColor),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColor),
          ),
        ),),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: customButton(text: 'Submit', onTap: (){
          print(_ratingController.rating);
          _ratingController.postRating(apartmentUid: apartmentUid,
              ratedBy: ratedBy,
              comments: comments,
              time: time,
              context: context);
        }),
      )
    ],
  );
}