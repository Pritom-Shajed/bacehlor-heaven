import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/category_controller.dart';
import 'package:bachelor_heaven/controller/booking/rating_controller.dart';
import 'package:bachelor_heaven/view/dashboard/ads_details.dart';
import 'package:bachelor_heaven/widgets/apartmentCard.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/customContainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  TextEditingController searchTextController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RatingController _ratingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: controller.flatSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.flat
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'FLAT',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.flat
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: controller.roomSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.room
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'ROOM',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.room
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: controller.seatSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.seat
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'SEAT',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.seat
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpaceSmall,
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('Ads-All')
                  .where('category',
                      isEqualTo: controller.selected == Selected.flat
                          ? 'Flat'
                          : controller.selected == Selected.room
                              ? 'Room'
                              : controller.selected == Selected.seat
                                  ? 'Seat'
                                  : '')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    // _ratingController.ratingChange(ratingActual: 5);
                    return ListView.separated(
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            height: 14,
                          );
                        },
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          Map<String, dynamic> adds =
                              snapshot.data!.docs[index].data();
                          return ApartmentCard2(
                              context: context,
                              bookingTitle: adds['title'],
                              bookingLocation: adds['location'],
                              imgUrl: adds['pictureUrl'],
                              rating: 5,
                              onTap: () => Get.to(
                                  () => ApartmentDetails(uid: adds['uid'])),
                              price: adds['price'],
                              pricePerNightOrMonth: adds['category'] == 'Seat'
                                  ? ' /month'
                                  : ' /night');
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
              },
            ),
          ),
        ],
      );
    });
  }
}
