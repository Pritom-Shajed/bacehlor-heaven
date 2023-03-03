import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/home_controller.dart';
import 'package:bachelor_heaven/view/dashboard/apartments.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/home%20screen/home_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                    color: _controller.currentIndex.value == i
                                        ? amberColor
                                        : whiteColor,
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
            () => Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('allAdds')
                    .where('location',
                        isGreaterThanOrEqualTo: _controller.searchName.value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.8),
                          itemBuilder: (_, index) {
                            Map<String, dynamic> adds =
                                snapshot.data!.docs[index].data();
                            return CachedNetworkImage(
                              imageUrl: "${adds['pictureUrl']}",
                              imageBuilder: (context, imageProvider) =>
                                  InkWell(
                                onTap: () {
                                  Get.to(()=>ApartmentDetails(
                                    uid: adds['uid'],
                                  ),);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          adds['category'],
                                          style: poppinsTextStyle(size: 10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          adds['location'],
                                          style: poppinsTextStyle(size: 10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          adds['price'],
                                          style: poppinsTextStyle(size: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Padding(
                                  padding: EdgeInsets.all(8),
                                  child:
                                      ShimmerEffect(height: 240, width: 200)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
          )
        ],
      ),
    );
  }
}
