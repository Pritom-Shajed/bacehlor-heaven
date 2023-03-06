import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/booking_controller.dart';
import 'package:bachelor_heaven/widgets/common/expanstion_tile.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/customContainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApartmentDetails extends StatelessWidget {
  ApartmentDetails({Key? key, required this.uid}) : super(key: key);
  String uid;
  DateTime? initialDate;
  DateTime? lastDate;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser = FirebaseAuth.instance.currentUser;
  BookingController _controller = Get.put(BookingController());
  String _currentTime = DateFormat.yMMMMd('en_US').add_jms().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: Colors.blueGrey,
            expandedHeight: MediaQuery.of(context).size.height/2.2,
            floating: true,
            pinned: true,
            flexibleSpace: StreamBuilder(
                stream: _firestore.collection('Ads-All').where('uid', isEqualTo: uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> apartment =
                      snapshot.data!.docs[0].data();
                      return Column(
                        children: [
                          Expanded(
                            child: FlexibleSpaceBar(
                             title: Text(
                                '${apartment['title']}',
                                style: poppinsTextStyle(
                                    size: 28, fontWeight: FontWeight.bold),
                              ),
                              background: CachedNetworkImage(
                                imageUrl: "${apartment['pictureUrl']}",
                                imageBuilder: (context, imageProvider) => Container(
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                placeholder: (context, url) => ShimmerEffect(
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  width: double.maxFinite,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),

                        ],
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
                        ));
                  }
                }),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
                  stream: _firestore
                      .collection('Ads-All')
                      .where('uid', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> apartment =
                        snapshot.data!.docs[0].data();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '৳${apartment['price']}',
                                          style: poppinsTextStyle( color: blackColor,size: 18,fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          apartment['category'] == 'Seat'? ' /month': ' /night',
                                          style: poppinsTextStyle(
                                              color: greyColor, size: 18),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'incl. of all taxes and duties',
                                      style: poppinsTextStyle(
                                          color: greyColor, size: 12),
                                    ),
                                    Text(
                                      '${apartment['location']}',
                                      style: poppinsTextStyle(size: 18),
                                    ),
                                    Text(
                                      'Category: ${apartment['category']}',
                                      style: poppinsTextStyle(size: 12),
                                    ),
                                    Text(
                                      'Posted on: ${apartment['postDate']}',
                                      style: poppinsTextStyle(size: 12),
                                    ),
                                    Divider(),
                                    expansionTile(title: 'Description', children: [
                                      Text('${apartment['description']}'),
                                    ]),
                                    expansionTile(title: 'Reviews', children: [
                                      Text('Reviews'),
                                    ]),
                                    verticalSpace,
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: blueColor,
                                            ),
                                            child: IconButton(color: whiteColor, icon: Icon(Icons.call), onPressed: () {  },)),
                                        horizontalSpace,
                                        Expanded(
                                          child: customButton(
                                              text: 'Book',
                                              onTap: () {
                                                _currentUser != null? showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        contentPadding:EdgeInsets.all(8),
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Center(child: Text('${apartment['title']}',
                                                            style: poppinsTextStyle(size: 20,fontWeight:FontWeight.w600),
                                                          )),
                                                          Divider(color: greyColor,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Dates', style: poppinsTextStyle(size: 16, fontWeight: FontWeight.w600),),
                                                              InkWell(onTap: () {
                                                                _controller.checkInDate.value = '';
                                                                _controller.checkOutDate.value = '';
                                                              },
                                                                  child: Text('Clear', style: poppinsTextStyle(size: 16, color: deepBrown),))
                                                            ],
                                                          ),
                                                          verticalSpaceSmall,
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              customContainer(
                                                                padding: EdgeInsets.all(14),
                                                                child: Row(
                                                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () async {
                                                                        initialDate = await showDatePicker(
                                                                          context:context,
                                                                          initialDate:DateTime.now(),
                                                                          firstDate:DateTime(2000),
                                                                          lastDate: DateTime(2050),
                                                                        );
                                                                        if (initialDate !=null) { _controller.formatCheckInDate(initialDate!);
                                                                        }
                                                                      },
                                                                      child: Obx(
                                                                            () => Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.apartment),
                                                                                Text('Check-in'),
                                                                              ],
                                                                            ),
                                                                            _controller.checkInDate.value ==''? Container(): Text(_controller.checkInDate.value),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () async {
                                                                        lastDate =
                                                                        await showDatePicker(
                                                                          context:
                                                                          context,
                                                                          initialDate:
                                                                          DateTime.now(),
                                                                          firstDate:
                                                                          DateTime(2000),
                                                                          lastDate:
                                                                          DateTime(2050),
                                                                        );
                                                                        if (lastDate != null) {
                                                                          _controller.formatCheckOutDate(lastDate!);
                                                                        }
                                                                      },
                                                                      child: Obx(
                                                                            () => Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(Icons.apartment),
                                                                                Text(
                                                                                    'Check-out'),
                                                                              ],
                                                                            ),
                                                                            _controller.checkOutDate.value ==''? Container(): Text(_controller.checkOutDate.value),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              verticalSpace,
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('Guests', style: poppinsTextStyle(size: 16, fontWeight: FontWeight.w600),),
                                                                  InkWell(onTap: () =>_controller.persons.value = 0,
                                                                      child: Text('Clear', style: poppinsTextStyle(size: 16, color: deepBrown),))
                                                                ],
                                                              ),
                                                              verticalSpaceSmall,
                                                              customContainer(
                                                                padding: EdgeInsets.all(14),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Person',
                                                                      style: poppinsTextStyle(
                                                                          color:
                                                                          blackColor,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                    ),
                                                                    horizontalSpace,
                                                                    Row(
                                                                      children: [
                                                                        InkWell(
                                                                            onTap: () => _controller.persons.value != 0 ? _controller.personDecrement()
                                                                                : null,
                                                                            child: Icon(
                                                                                Icons
                                                                                    .remove)),
                                                                        horizontalSpace,
                                                                        Obx(
                                                                              () => Text(
                                                                            '${_controller.persons.value}',
                                                                            style: poppinsTextStyle(
                                                                                fontWeight:
                                                                                FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        horizontalSpace,
                                                                        InkWell(
                                                                            onTap: () =>
                                                                                _controller.personIncrement(),
                                                                            child: Icon(
                                                                                Icons.add)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text('Preliminary Cost',
                                                                    style:poppinsTextStyle(color:greyColor,fontWeight:FontWeight.w500),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text('৳${apartment['price']}',
                                                                        style: poppinsTextStyle(color:blackColor,size: 18,fontWeight:FontWeight.w600),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Expanded(
                                                                child: customButton(
                                                                    text: 'Confirm',
                                                                    onTap: () {
                                                                      if(_controller.checkInDate.value == ''){
                                                                        Fluttertoast.showToast(msg: 'Pick check-in date');
                                                                      } else if(_controller.checkOutDate.value == ''){
                                                                        Fluttertoast.showToast(msg: 'Pick check-out date');
                                                                      } else if(_controller.persons.value == 0){
                                                                        Fluttertoast.showToast(msg: 'At least 1 person is required');
                                                                      } else {
                                                                        _controller.confirmBooking(
                                                                          context: context,
                                                                          addOwnerUid: apartment['adOwnerUid'],
                                                                          time: _currentTime,
                                                                          category: apartment['category'],
                                                                          title: apartment['title'],
                                                                          pictureUrl: apartment['pictureUrl'],
                                                                          checkIn: _controller.checkInDate.value,
                                                                          checkOut:_controller.checkOutDate.value,
                                                                          persons:'${_controller.persons.value}',
                                                                          userUid:'${_currentUser!.uid}',
                                                                          apartmentUid: '${apartment['uid']}',);
                                                                      }

                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                    : Fluttertoast.showToast(
                                                    msg:
                                                    'Login first to book your desired place');
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
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
                          ));
                    }
                  }),
          ),
        ],
      ),
    );
  }
}
