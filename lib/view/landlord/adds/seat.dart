import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/view/landlord/adds/apartment_details_personal.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSeats extends StatelessWidget {
  UserSeats({super.key});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(top: 65),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: bgColor),
              child: Column(
                children: [
                  Text(
                    'Bachelor Heaven',
                    style: satisfyTextStyle(size: 34, color: whiteColor),
                  ),
                  Text(
                    'Seats',
                    style: poppinsTextStyle(
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ),
                  Text(
                    'Click on the item to view details',
                    style: poppinsTextStyle(size: 12, color: whiteColor),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 180,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black38,
                    ),
                  ],
                ),
                child: StreamBuilder(
                  stream: _firestore
                      .collection('individualAdds')
                      .doc('user_${_currentUser!.uid}')
                      .collection('Seat')
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
                              Map<String, dynamic> seats =
                                  snapshot.data!.docs[index].data();
                              return InkWell(
                                onTap: ()=>Get.to(()=>ApartmentDetailsPersonal(uid: seats['uid'])),
                                child: CachedNetworkImage(
                                  imageUrl: "${seats['pictureUrl']}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                          child: Text(seats['location']),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(seats['price']),
                                        ),
                                      ],
                                    ),
                                  ),
                                  placeholder: (context, url) => Padding(
                                      padding: EdgeInsets.all(8),
                                      child:
                                          ShimmerEffect(height: 240, width: 200)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text('Error Occurred, please try again');
                      } else {
                        return Container(
                          child: Text('No data'),
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
      ),
    );
  }
}
