import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/bookingCard.dart';
import 'package:bachelor_heaven/widgets/common/alert_dialog.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/customContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/booking/booking_controller.dart';

class MyBookings extends StatelessWidget {
  MyBookings({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Bookings',
            style: poppinsTextStyle(color: blackColor),
          ),
        ),
        body: GetBuilder<BookingController>(builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: controller.confirmedBookings,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: controller.booking == Booking.confirm
                                ? blackColor
                                : whiteColor,
                            border: Border.all(color: blackColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Confirmed',
                          style: poppinsTextStyle(
                              color: controller.booking == Booking.confirm
                                  ? whiteColor
                                  : blackColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: controller.requestedBookings,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: controller.booking == Booking.pending
                                ? blackColor
                                : whiteColor,
                            border: Border.all(color: blackColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Pending',
                          style: poppinsTextStyle(
                              color: controller.booking == Booking.pending
                                  ? whiteColor
                                  : blackColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: controller.cancelledBookings,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: controller.booking == Booking.cancel
                                ? blackColor
                                : whiteColor,
                            border: Border.all(color: blackColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Cancelled',
                          style: poppinsTextStyle(
                              color: controller.booking == Booking.cancel
                                  ? whiteColor
                                  : blackColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: controller.booking == Booking.cancel
                    ? StreamBuilder(
                        stream: _firestore
                            .collection('CancelledBookings-Users')
                            .where('adBookedByUid',
                                isEqualTo: _currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                separatorBuilder: (context, index){
                                  return Divider(color: shadowColor,);
                                },
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> bookings =
                                        snapshot.data!.docs[index].data();

                                    return BookingCard(
                                        context: context,
                                        imageUrl: bookings['pictureUrl'],
                                        apartmentTitle: bookings['title'],
                                        personsTotal: bookings['persons'],
                                        location: bookings['address'],
                                        price: bookings['price'], category: 'Seat',
                                        buttonOne: bookingButtonContainer(
                                            color: deepBrown,
                                            text: 'Cancelled'),
                                        buttonTwo: Container());
                                  });
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error Occured'),
                              );
                            } else {
                              return Center(
                                child: Text('Something went wrong'),
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: blackColor,
                              ),
                            );
                          }
                        })
                    : StreamBuilder(
                        stream: _firestore
                            .collection('Bookings')
                            .where('adBookedByUid',
                                isEqualTo: _currentUser!.uid)
                            .where('bookingStatus',
                                isEqualTo: controller.booking == Booking.pending
                                    ? 'Pending'
                                    : controller.booking == Booking.confirm
                                        ? 'Confirmed'
                                        : '')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> bookings =
                                        snapshot.data!.docs[index].data();
                                   return BookingCard(
                                      context: context,
                                      imageUrl: bookings['pictureUrl'],
                                      apartmentTitle: bookings['title'],
                                      personsTotal: bookings['persons'],
                                      location: bookings['address'],
                                      price: bookings['price'], category: 'Seat',
                                      cancelled: bookings['cancelled'],
                                      buttonOne: bookings['cancelled'] == 'No' ? bookingButtonContainer(
                                          text: bookings[
                                          'bookingStatus'],
                                          color: bookings[
                                          'bookingStatus'] ==
                                              'Pending'
                                              ? deepBrown
                                              : greenColor): bookingButtonContainer(
                                          text: bookings[
                                          'cancelled'] ==
                                              'Requested'
                                              ? 'Requested to cancel'
                                              : 'Cancelled',
                                          color: deepBrown),
                                      buttonTwo: bookings['bookingStatus'] ==
                                          'Confirmed'
                                          ? Container()
                                          : customButton(
                                          text: 'Cancel',
                                          onTap: () =>
                                              alertDialog(
                                                  context:
                                                  context,
                                                  title:
                                                  'Cancel booking?',
                                                  onTapYes:
                                                      () {
                                                    controller.cancelBookingRequest(
                                                        context:
                                                        context,
                                                        cancelled:
                                                        'Requested',
                                                        adBookedByUid:
                                                        bookings['adBookedByUid'],
                                                        bookingUid: bookings['bookingUid']);
                                                  },
                                                  onTapNo: () =>
                                                      Get.back())));
                                  });
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error Occured'),
                              );
                            } else {
                              return Center(
                                child: Text('Something went wrong'),
                              );
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: blackColor,
                              ),
                            );
                          }
                        }),
              ),
            ],
          );
        }));
  }
}
