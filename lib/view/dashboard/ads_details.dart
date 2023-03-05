import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/booking_controller.dart';
import 'package:bachelor_heaven/widgets/common/expanstion_tile.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
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
                      CachedNetworkImage(
                        imageUrl: "${apartment['pictureUrl']}",
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        ),
                        placeholder: (context, url) => ShimmerEffect(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.maxFinite,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Posted on: ${apartment['postDate']}',
                                  style: poppinsTextStyle(size: 12),
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
                                  '${apartment['title']}',
                                  style: poppinsTextStyle(
                                      size: 32, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${apartment['price']}tk',
                                      style: poppinsTextStyle(
                                          color: blackColor,
                                          size: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      apartment['category'] == 'Seat'
                                          ? ' /month'
                                          : ' /night',
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
                                Divider(),
                                expansionTile(title: 'Description', children: [
                                  Text('${apartment['description']}'),
                                ]),
                                expansionTile(title: 'Reviews', children: [
                                  Text('Reviews'),
                                ]),
                                verticalSpace,
                                customButton(
                                    text: 'Book',
                                    onTap: () {
                                      _currentUser != null
                                          ? showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SimpleDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(8),
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      '${apartment['title']}',
                                                      style: poppinsTextStyle(
                                                          size: 20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                                    Divider(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Price:',
                                                          style:
                                                              poppinsTextStyle(
                                                                  color:
                                                                      bgColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${apartment['price']}tk',
                                                              style: poppinsTextStyle(
                                                                  color:
                                                                      blackColor,
                                                                  size: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              apartment['category'] ==
                                                                      'Seat'
                                                                  ? ' /month'
                                                                  : ' /night',
                                                              style: poppinsTextStyle(
                                                                  color:
                                                                      greyColor,
                                                                  size: 18),
                                                            ),
                                                          ],
                                                        ),
                                                        verticalSpace,
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                initialDate =
                                                                    await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2000),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2050),
                                                                );
                                                                if (initialDate !=
                                                                    null) {
                                                                  _controller
                                                                      .formatCheckInDate(
                                                                          initialDate!);
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            blackColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                child: Obx(
                                                                  () => Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .apartment),
                                                                          Text(
                                                                              'Check-in'),
                                                                        ],
                                                                      ),
                                                                      _controller.checkInDate.value ==
                                                                              ''
                                                                          ? Container()
                                                                          : Text(_controller
                                                                              .checkInDate
                                                                              .value),
                                                                    ],
                                                                  ),
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
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2000),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2050),
                                                                );
                                                                if (lastDate !=
                                                                    null) {
                                                                  _controller
                                                                      .formatCheckOutDate(
                                                                          lastDate!);
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color:
                                                                            blackColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                child: Obx(
                                                                  () => Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .apartment),
                                                                          Text(
                                                                              'Check-out'),
                                                                        ],
                                                                      ),
                                                                      _controller.checkOutDate.value ==
                                                                              ''
                                                                          ? Container()
                                                                          : Text(_controller
                                                                              .checkOutDate
                                                                              .value),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        verticalSpace,
                                                        Row(
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
                                                                    onTap: () => _controller.persons.value !=
                                                                            0
                                                                        ? _controller
                                                                            .personDecrement()
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
                                                                        _controller
                                                                            .personIncrement(),
                                                                    child: Icon(
                                                                        Icons
                                                                            .add)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    verticalSpace,
                                                    customButton(
                                                        text: 'Confirm',
                                                        onTap: () {
                                                          if(_controller.checkInDate.value == ''){
                                                            Fluttertoast.showToast(msg: 'Pick check-in date');
                                                          } else if(_controller.checkOutDate.value == ''){
                                                            Fluttertoast.showToast(msg: 'Pick check-out date');
                                                          } else if(_controller.persons.value == 0){
                                                            Fluttertoast.showToast(msg: 'At least 1 person is required');
                                                          } else {
                                                            _controller
                                                                .confirmBooking(
                                                              context: context,
                                                              time: _currentTime,
                                                              category: apartment['category'],
                                                              title: apartment['title'],
                                                              pictureUrl: apartment['pictureUrl'],
                                                              checkIn:
                                                              _controller.checkInDate.value,
                                                              checkOut:
                                                              _controller.checkOutDate.value,
                                                              persons:
                                                              '${_controller.persons.value}',
                                                              userUid:
                                                              '${_currentUser!.uid}',
                                                              apartmentUid:
                                                              '${apartment['uid']}',);
                                                          }

                                                        }),
                                                  ],
                                                );
                                              })
                                          : Fluttertoast.showToast(
                                              msg:
                                                  'Login first to book your desired place');
                                    }),
                              ],
                            ),
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
    );
  }
}
