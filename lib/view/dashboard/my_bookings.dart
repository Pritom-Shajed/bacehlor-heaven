import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatelessWidget {
  MyBookings({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings', style: poppinsTextStyle(color: blackColor),),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('Bookings')
              .where('bookedByUid', isEqualTo: _currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> bookings =
                          snapshot.data!.docs[index].data();

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                radius: 30,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              bookings['pictureUrl']), fit: BoxFit.cover)),
                                )),
                              ),
                              horizontalSpace,
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bookings['title'], style: poppinsTextStyle(fontWeight: FontWeight.w600),),
                                    RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: 'Persons: ',style: poppinsTextStyle(color: blackColor),),
                                        TextSpan(text: bookings['persons'],style: poppinsTextStyle(color: blackColor),),
                                      ]
                                    )),
                                    RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text: 'Check-in: ',style: poppinsTextStyle(color: blackColor),),
                                          TextSpan(text: bookings['checkIn'],style: poppinsTextStyle(color: blackColor),),
                                        ]
                                    )),
                                    RichText(text: TextSpan(
                                        children: [
                                          TextSpan(text: 'Check-out: ',style: poppinsTextStyle(color: blackColor),),
                                          TextSpan(text: bookings['checkIn'],style: poppinsTextStyle(color: blackColor),),
                                        ]
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    customButton(color: Colors.green.shade800,text: 'Confirmed', onTap: (){}),
                                    // customButton(color: deepBrown,text: 'In progress..', onTap: (){}),
                                    verticalSpaceSmall,
                                    customButton(text: 'Cancel', onTap: (){})
                                  ]
                                ),
                              )

                            ],
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
          }),
    );
  }
}
