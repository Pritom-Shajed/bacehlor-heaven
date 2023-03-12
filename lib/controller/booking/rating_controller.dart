import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/model/rating_model.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  final _rating = 3.0.obs;

  get rating => _rating.value;

  set rating(value) {
    _rating.value = value;
  }



  updateRating(double ratingActual) {
    rating = ratingActual;
  }

  postRating(
      {required String apartmentUid,
      required String comments,
      required String time,
      required BuildContext context,
      required String ratedBy,
      required String bookingUid}) async {
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
        apartmentUid: apartmentUid,
        comments: comments,
        rating: rating,
        ratedBy: ratedBy);

    await FirebaseFirestore.instance
        .collection('Ratings')
        .doc(time)
        .set(_ratingModel.toJson())
        .then((value) => deleteRatedBookings(bookingUid: bookingUid))
        .then((value) =>
            Fluttertoast.showToast(msg: 'Thanks for your honest review!'))
        .then((value) => Get.offAllNamed('/dashboard'));
  }

  deleteRatedBookings({required String bookingUid}) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Bookings')
        .where('bookingUid', isEqualTo: bookingUid)
        .get();

    snapshot.docs.single.reference.delete();
  }


}
