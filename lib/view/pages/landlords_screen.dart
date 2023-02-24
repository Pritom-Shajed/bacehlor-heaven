import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandlordsScreen extends StatelessWidget {
  LandlordsScreen({Key? key}) : super(key: key);
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Our Registered LandLoards',
            style: poppinsTextStyle(fontWeight: FontWeight.bold, size: 16),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: _firestore.collection('users').snapshots(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data();
                          return Card(
                            child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: whiteColor),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: lightGreyColor,
                                    backgroundImage:
                                        NetworkImage(userMap['profilePic']),
                                  ),
                                  horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Name: ',
                                            style: poppinsTextStyle(
                                                size: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${userMap['name']}',
                                            style: poppinsTextStyle(size: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Location: ',
                                            style: poppinsTextStyle(
                                                size: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${userMap['location']}',
                                            style: poppinsTextStyle(size: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Joined: ',
                                            style: poppinsTextStyle(
                                                size: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${userMap['joinedDate']}',
                                            style: poppinsTextStyle(size: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text('No Registred Landlords Found!'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
