import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/dashboard/category_controller.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: controller.flatSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.flat
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'FLAT',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.flat
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: controller.roomSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.room
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'ROOM',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.room
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: controller.seatSelected,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: controller.selected == Selected.seat
                            ? blackColor
                            : whiteColor,
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      'SEAT',
                      style: poppinsTextStyle(
                          color: controller.selected == Selected.seat
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
