import 'package:bachelor_heaven/view/home_screen.dart';
import 'package:bachelor_heaven/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bachelor Heaven',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: [
        GetPage(name: '/splash_screen', page: () => SplashScreen()),
        GetPage(name: '/home_screen', page: () => HomeScreen()),
      ],
      initialRoute: '/splash_screen',
    );
  }
}
