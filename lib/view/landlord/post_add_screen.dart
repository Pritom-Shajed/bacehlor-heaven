import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/landlord/post_add_controller.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostAdd extends StatefulWidget {
  PostAdd({super.key});

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  TextEditingController _locationController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  final List<String> items = ['Seat', 'Flat', 'Room'];

  String initialValue = 'Seat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PostAddController>(builder: (controller) {
        return SingleChildScrollView(
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
                      'Post Your Add',
                      style: poppinsTextStyle(
                          size: 24,
                          fontWeight: FontWeight.bold,
                          color: whiteColor),
                    ),
                    Text(
                      'Enter the below details to continue',
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
                  child: Column(
                    children: [
                      controller.addImage == null
                          ? Container()
                          : Container(
                              height: 200,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(55),
                                      topRight: Radius.circular(55)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(controller.addImage!))),
                            ),
                      verticalSpace,
                      customTextField(
                          controller: _locationController,
                          hintText: 'Location',
                          icon: Icons.location_city),
                      customTextField(
                          controller: _priceController,
                          hintText: 'Price',
                          icon: Icons.price_change),
                      Card(
                        elevation: 1,
                        child: DropdownButtonFormField(
                          value: initialValue,
                          onChanged: (value) {},
                          items: items
                              .map((valueItem) => DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(
                                    valueItem,
                                  )))
                              .toList(),
                          icon: Icon(Icons.arrow_drop_down_circle),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(
                              Icons.category_rounded,
                              color: blackColor,
                            ),
                            labelText: 'Category',
                            labelStyle: TextStyle(color: Colors.grey.shade700),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.pickCamOrGallery(context);
                          // controller.pickAddImage(ImageSource.gallery);
                        },
                        child: Card(
                          elevation: 1,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(Icons.photo_rounded),
                                horizontalSpace,
                                controller.addImage == null
                                    ? Text(
                                        'Add Photo',
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      )
                                    : Text('Change Photo',
                                        style: TextStyle(color: blackColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      verticalSpace,
                      customButton(
                          text: 'ADD',
                          onTap: () {
                            if (_locationController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Enter your location',
                                  toastLength: Toast.LENGTH_SHORT);
                            } else if (_priceController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Enter the price',
                                  toastLength: Toast.LENGTH_SHORT);
                            } else if (controller.addImage == null) {
                              Fluttertoast.showToast(
                                  msg: 'Add a photo',
                                  toastLength: Toast.LENGTH_SHORT);
                            } else {
                              Fluttertoast.showToast(
                                      msg: 'Added!',
                                      toastLength: Toast.LENGTH_SHORT)
                                  .then(
                                      (value) => Get.offAllNamed('/nav_panel'));
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
