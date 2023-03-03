import 'package:bachelor_heaven/controller/intial/bottom_nav_controller.dart';
import 'package:bachelor_heaven/view/landlord/profile/profile_screen.dart';
import 'package:bachelor_heaven/view/dashboard/category_screen.dart';
import 'package:bachelor_heaven/view/dashboard/home_screen.dart';
import 'package:bachelor_heaven/view/dashboard/landlords_screen.dart';
import 'package:bachelor_heaven/view/landlord/profile/profile(unused).dart';
import 'package:bachelor_heaven/widgets/common/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../widgets/home screen/home_widgets.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomeScreen(),
      CategoryScreen(),
      LandlordsScreen(),
    ];
    return GetBuilder<BottomNavController>(builder: (controller) {
      return WillPopScope(
        onWillPop: ()  {
            return alertDialog(context: context,title: 'Are you sure to exit?', onTapYes: ()=>SystemNavigator.pop(), onTapNo: ()=>Get.back());
        },
        child: Scaffold(
          drawer: _currentUser == null
              ? DrawerWidget(context)
              : LoggedInDrawer(
                  context: context,
                  text: _currentUser!.displayName!,
                  image: _currentUser!.photoURL!),
          appBar: AppBar(
            elevation: 0,
            actions: [
              _currentUser != null
                  ? IconButton(
                      onPressed: () => Get.toNamed('/profile_screen'),
                      icon: Icon(Icons.account_circle))
                  : Container()
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.category,
                      text: 'Categories',
                    ),
                    GButton(
                      icon: Icons.account_circle,
                      text: 'Landlords',
                    ),
                  ],
                  selectedIndex: controller.tabIndex,
                  onTabChange: controller.changeTabIndex,
                ),
              ),
            ),
          ),
          body: _pages[controller.tabIndex],
        ),
      );
    });
  }
}
