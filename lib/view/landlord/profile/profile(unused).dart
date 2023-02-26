import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/controller/landlord/profile/profile_controller.dart';
import 'package:bachelor_heaven/model/landlord/user_model.dart';
import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:bachelor_heaven/widgets/landloard/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // future: _controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;

              //Controllers
              final _name = TextEditingController(text: userData.name);
              final _email = TextEditingController(text: userData.email);
              final _location = TextEditingController(text: userData.location);

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
                            style:
                                satisfyTextStyle(size: 34, color: whiteColor),
                          ),
                          Text(
                            'My Profile',
                            style: poppinsTextStyle(
                                size: 24,
                                fontWeight: FontWeight.bold,
                                color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 170,
                      bottom: 0,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
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
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: lightGreyColor,
                                backgroundImage:
                                    NetworkImage(userData.profilePic as String),
                              ),
                              verticalSpace,
                              Text(
                                '${userData.name}',
                                style: poppinsTextStyle(
                                    size: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Joined: ${userData.joinedDate}',
                                style: poppinsTextStyle(
                                    color: greyColor,
                                    size: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              verticalSpace,
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email:',
                                      style: poppinsTextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${userData.email}',
                                      style: poppinsTextStyle(size: 15),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace,
                              Container(
                                padding: EdgeInsets.all(10),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location:',
                                      style: poppinsTextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${userData.location}',
                                      style: poppinsTextStyle(size: 15),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: customButton(
                                        text: 'Edit Profile',
                                        onTap: () => editProfileDialog(
                                            context: context,
                                            nameController: _name,
                                            emailController: _email,
                                            locationController: _location,
                                            onTap: () async {
                                              print('tapped');
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (_) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  });
                                              final user = UserModel(
                                                  name: _name.text.trim(),
                                                  email: _email.text.trim(),
                                                  profilePic:
                                                      userData.profilePic,
                                                  uid: userData.uid,
                                                  location:
                                                      _location.text.trim(),
                                                  joinedDate:
                                                      userData.joinedDate);

                                              await _controller
                                                  .updateUserData(user);
                                            }),
                                      )),
                                  horizontalSpace,
                                  Expanded(
                                    flex: 1,
                                    child: customButton(
                                        color: redColor,
                                        text: 'Delete Profile',
                                        onTap: () {
                                          print('edit');
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Text('Something Went Wrong'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
