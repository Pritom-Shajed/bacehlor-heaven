import 'package:bachelor_heaven/bindings/bindings.dart';
import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/view/auth/login_screen.dart';
import 'package:bachelor_heaven/view/bottom_nav.dart';
import 'package:bachelor_heaven/view/pages/home_screen.dart';
import 'package:bachelor_heaven/view/pages/landlords_screen.dart';
import 'package:bachelor_heaven/view/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bachelor Heaven',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.white,
              iconTheme: IconThemeData(color: blackColor)),
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: [
        GetPage(name: '/splash_screen', page: () => SplashScreen()),
        GetPage(name: '/home_screen', page: () => HomeScreen()),
        GetPage(name: '/nav_panel', page: () => BottomNav()),
        GetPage(name: '/landlords_screen', page: () => LandlordsScreen()),
        GetPage(name: '/login_screen', page: () => LoginScreen())
      ],
      initialRoute: '/nav_panel',
      initialBinding: InitialBinding(),
    );
  }
}
