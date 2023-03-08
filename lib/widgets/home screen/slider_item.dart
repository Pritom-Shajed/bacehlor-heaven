import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

class sliderItemWidget extends StatelessWidget {
  String image;
  String text;
  sliderItemWidget({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
      child: Stack(
        children: [
          Text(text, style: poppinsTextStyle(size: 30, color: whiteColor)),
        ],
      ),
    );
  }
}
