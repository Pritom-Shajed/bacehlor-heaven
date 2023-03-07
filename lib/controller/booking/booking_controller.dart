import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/model/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BookingController extends GetxController {
  RxString checkInDate = ''.obs;
  RxString checkOutDate = ''.obs;
  RxInt persons = 0.obs;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void personIncrement() {
    persons.value++;
  }

  void personDecrement() {
    persons.value--;
  }

  formatCheckInDate(DateTime initialDate) async {
    checkInDate.value = DateFormat('yyyy-MM-dd').format(initialDate);
  }

  formatCheckOutDate(DateTime initialDate) async {
    checkOutDate.value = DateFormat('yyyy-MM-dd').format(initialDate);
  }

  confirmBooking(
      {required bookingStatus,
      required cancelled,
      required addOwnerUid,
      required BuildContext context,
      required String time,
      required String pictureUrl,
      required String title,
      required String checkIn,
      required String checkOut,
      required String persons,
      required String userUid,
      required String category,
      required String apartmentUid}) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: whiteColor,
            ),
          );
        });
    BookingModel data = BookingModel(
      bookingStatus: bookingStatus,
      bookingUid: Uuid().v1(),
      cancelled: cancelled,
      adOwnerUid: addOwnerUid,
      checkIn: checkIn,
      checkOut: checkOut,
      persons: persons,
      adBookedByUid: userUid,
      apartmentUid: apartmentUid,
      category: category,
      title: title,
      pictureUrl: pictureUrl,
    );
    await _firestore
        .collection('Bookings')
        .doc(time)
        .set(data.toJson())
        .then((value) => Fluttertoast.showToast(
            msg: 'Booking requested, wait for confirmation'))
        .then((value) => Get.offAllNamed('/dashboard'));
  }

  cancelBookingRequest({
    required BuildContext context,
    required String cancelled,
    required String adBookedByUid,
    required String bookingUid,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: whiteColor,
            ),
          );
        });
    CancelBookingModel cancelBookingModel = CancelBookingModel(
      cancelled: cancelled,
    );

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Bookings')
        .where('adBookedByUid', isEqualTo: adBookedByUid)
        .where('bookingUid', isEqualTo: bookingUid)
        .get();

    snapshot.docs.forEach((element) {
      element.reference.update(cancelBookingModel.toJson()).then((value) =>
          Fluttertoast.showToast(msg: 'Cancel request sent...')
              .then((value) => Get.offAllNamed('/dashboard')));
    });
  }

}
