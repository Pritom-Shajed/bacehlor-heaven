import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/booking/booking_controller.dart';
import 'package:bachelor_heaven/controller/dashboard/home_controller.dart';
import 'package:bachelor_heaven/controller/booking/rating_controller.dart';
import 'package:bachelor_heaven/view/dashboard/ads_details.dart';
import 'package:bachelor_heaven/widgets/apartmentCard.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/customContainer.dart';
import 'package:bachelor_heaven/widgets/home%20screen/home_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController _homeController = Get.find();

  TextEditingController searchTextController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CarouselController _carouselController = CarouselController();
  RatingController _ratingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: HeaderWidget(),
          ),
          Column(
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: sliderItems.length,
                    itemBuilder: (context, index, pageViewIndex) =>
                        sliderItems[index],
                    carouselController: _carouselController,
                    options: CarouselOptions(
                        scrollPhysics: BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2.3,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) =>
                            _homeController.updateSliderIndex(index)),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < sliderItems.length; i++)
                              Obx(
                                () => Container(
                                  margin: EdgeInsets.all(3),
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: _homeController.currentIndex == i
                                        ? whiteColor
                                        : whiteColor.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ])),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(() => Row(
                    children: [
                      Expanded(
                        child: searchBar(
                            controller: searchTextController,
                            onChanged: _homeController.searchByCity),
                      ),
                      _homeController.searchName.value != ''
                          ? InkWell(
                              onTap: () {
                                searchTextController.clear();
                                _homeController.searchName.value = '';
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: greyColor,
                                      child: Icon(
                                        size: 18,
                                        Icons.clear,
                                        color: whiteColor,
                                      ))))
                          : Container()
                    ],
                  )),
            ],
          ),
          Expanded(
            child: Obx(
              () => StreamBuilder(
                stream: _firestore
                    .collection('Ads-All')
                    .where('locationSearch',
                        isGreaterThanOrEqualTo: _homeController.searchName.value.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
                          itemBuilder: (_, index) {
                            Map<String, dynamic> adds = snapshot.data!.docs[index].data();
                            // _ratingController.ratingChange(ratingActual: 4);
                            return ApartmentCard(
                                onTap: () {
                                  Get.to(() => ApartmentDetails(uid: adds['uid']));
                                },
                                bookingTitle: adds['title'],
                                bookingLocation: adds['division'],
                                imgUrl: adds['pictureUrl']);
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
          ),
        ],
      ),
    );
  }
}
