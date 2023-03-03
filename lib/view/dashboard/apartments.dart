import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApartmentDetails extends StatelessWidget {
  ApartmentDetails({Key? key, required this.uid}) : super(key: key);
  String uid;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: _firestore
                .collection('allAdds')
                .where('uid', isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData){
                  Map<String, dynamic> apartment = snapshot.data!.docs[0].data();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                        "${apartment['pictureUrl']}",
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
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
                                Text(
                                  apartment['category'] == 'Seat' ? '${apartment['price']}tk per month': '${apartment['price']}tk per night',
                                  style: poppinsTextStyle(
                                      size: 18, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'incl. of all taxes and duties',
                                  style: poppinsTextStyle(color: greyColor, size: 12),
                                ),
                                Divider(),
                                Text(
                                  'Description',
                                  style: poppinsTextStyle(
                                      size: 18, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    '${apartment['description']}'),
                                verticalSpace,
                                customButton(text: 'Call', onTap: () {}),
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
                  child: CircularProgressIndicator(color: blackColor,)
                );
              }

            }),
      ),
    );
  }
}
