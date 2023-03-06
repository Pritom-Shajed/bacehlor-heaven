import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/category_controller.dart';
import 'package:bachelor_heaven/view/dashboard/ads_details.dart';
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
                    return GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.65),
                        itemBuilder: (_, index) {
                          Map<String, dynamic> adds =
                              snapshot.data!.docs[index].data();
                          return InkWell(
                            onTap: () => Get.to(
                              () => ApartmentDetails(
                                uid: adds['uid'],
                              ),
                            ),
                            child: customContainer(
                              margin: EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: "${adds['pictureUrl']}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 150,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          ShimmerEffect(
                                              height: 150,
                                              width: double.maxFinite),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    verticalSpaceSmall,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${adds['title']}',
                                          style: poppinsTextStyle(
                                              size: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                            text: '৳${adds['price']}',
                                            style: poppinsTextStyle(
                                                size: 14,
                                                color: deepBrown,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: adds['category'] == 'Seat '
                                                ? '/month'
                                                : '/night',
                                            style: poppinsTextStyle(
                                                size: 12, color: greyColor),
                                          ),
                                        ])),
                                        verticalSpaceSmall,
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              size: 19,
                                              color: greyColor,
                                            ),
                                            Text(
                                              adds['location'],
                                              style: poppinsTextStyle(size: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 19,
                                              color: amberColor,
                                            ),
                                            Text(
                                              '4.0',
                                              style: poppinsTextStyle(size: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
