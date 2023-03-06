import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/home_controller.dart';
import 'package:bachelor_heaven/view/dashboard/ads_details.dart';
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

  HomeController _controller = Get.find();

  TextEditingController searchTextController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5), child: HeaderWidget(),),
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
                              _controller.updateSliderIndex(index)),
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
                                      color:
                                      _controller.currentIndex.value == i
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
                Card(
                  elevation: 3,
                  child: Obx(() => Row(
                    children: [
                      Expanded(
                        child: searchBar(
                            controller: searchTextController,
                            onChanged: _controller.searchByCity),
                      ),
                      _controller.searchName.value != ''
                          ? InkWell(
                          onTap: () {
                            searchTextController.clear();
                            _controller.searchName.value = '';
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
                ),
              ],
            ),
            Obx(
                  () => StreamBuilder(
                stream: _firestore
                    .collection('Ads-All')
                    .where('location',
                    isGreaterThanOrEqualTo: _controller.searchName.value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: "${adds['pictureUrl']}",
                                          imageBuilder:
                                              (context, imageProvider) =>
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
                                                  style:
                                                  poppinsTextStyle(size: 12),
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
                                                  style:
                                                  poppinsTextStyle(size: 12),
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
                            }),
                      );
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
        ),);
  }
}
