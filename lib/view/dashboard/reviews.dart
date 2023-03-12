import 'package:bachelor_heaven/widgets/common/expanstion_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsController extends GetxController{

  List<Widget> reviews = [];

  Future<void> loadWidgetsAsync({required String apartmentUid}) async {
    // Assume that loadWidgetAsync() returns a Future<Widget>
    Widget widget = await ApartmentReviews(apartmentUid: apartmentUid);
    reviews.add(widget);
  }

  Future<Widget> ApartmentReviews({ required String apartmentUid}) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Ratings')
        .where('apartmentUid', isEqualTo: apartmentUid)
        .get();
    return Text(snapshot.docs.single['comments']);
  }
}


