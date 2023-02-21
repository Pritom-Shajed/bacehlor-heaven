import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';

class sliderItem extends StatelessWidget {
  String imageUrl;
  String text;
  sliderItem({super.key, required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageUrl))),
      child: Stack(
        children: [
          Text(text, style: poppinsTextStyle(size: 30, color: whiteColor)),
        ],
      ),
    );
  }
}
