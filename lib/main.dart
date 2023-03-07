import 'package:bachelor_heaven/bindings/bindings.dart';
import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/view/auth/login_screen.dart';
import 'package:bachelor_heaven/view/auth/registration_screen.dart';
import 'package:bachelor_heaven/view/dashboard/home_screen.dart';
import 'package:bachelor_heaven/view/dashboard/landlords_screen.dart';
import 'package:bachelor_heaven/view/intial/dashboard.dart';
import 'package:bachelor_heaven/view/intial/splash_screen.dart';
import 'package:bachelor_heaven/view/user/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view/dashboard/my_bookings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown, backgroundColor: whiteColor, cardColor: whiteColor),
        appBarTheme: AppBarTheme(
            elevation: 0,
              color: Colors.white,
              iconTheme: IconThemeData(color: blackColor)),
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: [
        GetPage(name: '/splash_screen', page: () => SplashScreen()),
        GetPage(name: '/login_screen',page: () => LoginScreen(),binding: AuthBinding()),
        GetPage(name: '/reg_screen',page: () => RegScreen(), binding: AuthBinding()),
        GetPage(name: '/profile_screen', page: () => ProfileScreen()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/my_bookings', page: ()=>MyBookings(), binding: BookingBinding()),
        GetPage(name: '/home_screen', page: () => HomeScreen()),
        GetPage(name: '/landlords_screen', page: () => LandlordsScreen()),
      ],
      initialRoute: '/splash_screen',
      initialBinding: InitialBinding(),
    );
  }
}
