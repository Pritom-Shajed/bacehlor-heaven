import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/model/rating_model.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  // RxInt rating = 0.obs;

  final _rating = 3.0.obs;

  get rating => _rating;

  set rating(value) {
    _rating.value = value;
  }

  // Widget ratingTotal({required Color textColor, required double iconSize, required double textSize}){
  //   int i = 0;
  //   return Row(
  //     children: [
  //       for(i; i < rating.value; i++)
  //         Icon(
  //           Icons.star,
  //           color: amberColor,
  //           size: iconSize,
  //         ),
  //       // Text(
  //       //   i.toString(),
  //       //   style: poppinsTextStyle(
  //       //       color: textColor,
  //       //       fontWeight: FontWeight.w600,
  //       //       size: textSize),
  //       // ),
  //     ],
  //   );
  // }


  updateRating(double ratingActual) {
    rating = ratingActual;
  }

  postRating(
      {required String apartmentUid,
      required String comments,
      required String time,
      required BuildContext context, required String ratedBy}) async {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: whiteColor,
            ),
          );
        });
    RatingModel _ratingModel = RatingModel(
        apartmentUid: apartmentUid, comments: comments, rating: rating.toString(), ratedBy: ratedBy);
    await FirebaseFirestore.instance
        .collection('Ratings')
        .doc(time)
        .set(_ratingModel.toJson())
        .then((value) =>
            Fluttertoast.showToast(msg: 'Thanks for your honest rating!'))
        .then((value) => Get.offAllNamed('/dashboard'));
  }

// void ratingChange({required int ratingActual}){
//   rating.value = ratingActual;
// }
}
