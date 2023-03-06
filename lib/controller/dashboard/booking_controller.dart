import 'package:bachelor_heaven/model/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      {required addOwnerUid,
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
            child: CircularProgressIndicator(),
          );
        });
    BookingModel data = BookingModel(
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
        .then((value) => Fluttertoast.showToast(msg: 'Booking completed'))
        .then((value) => Get.offAllNamed('/dashboard'));
  }
}
