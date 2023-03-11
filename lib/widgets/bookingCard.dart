import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/customContainer.dart';
import 'package:flutter/material.dart';

Widget BookingCard(
    {required BuildContext context,
    required String imageUrl,
    required String apartmentTitle,
    required String personsTotal,
    required String location,
    required String price,
    required String category, required Widget buttonOne, required Widget buttonTwo, String? cancelled}) {
  return Container(
    margin: EdgeInsets.all(5),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover)),
        ),
        horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                apartmentTitle,
                style: poppinsTextStyle(size: 24, fontWeight: FontWeight.w600),
              ),
              verticalSpaceSmall,
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 17,
                  ),
                  Expanded(
                      child: Text(
                    location,
                    style:
                        poppinsTextStyle(size: 14, fontWeight: FontWeight.w500),
                  ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 17,
                  ),
                  horizontalSpace,
                  Expanded(
                      child: Text(
                    personsTotal,
                    style:
                        poppinsTextStyle(size: 14, fontWeight: FontWeight.w500),
                  ))
                ],
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '৳$price',
                      style: poppinsTextStyle(
                          color: blackColor,
                          size: 14,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                    text: category == 'Seat' ? ' /month' : ' /night',
                    style: poppinsTextStyle(
                        color: greyColor,
                        size: 14,
                        fontWeight: FontWeight.w500),
                  )
                ]),
              ),
              verticalSpaceSmall,
              Row(
                children: [
                  Expanded(child: buttonOne),
                  horizontalSpace,
                 cancelled == 'No' ? Expanded(child: buttonTwo):Container(),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
