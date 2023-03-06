import 'dart:async';

import 'package:bachelor_heaven/widgets/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed('/dashboard');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 150, child: Image.asset('assets/icons/appIcon.png')),
              SizedBox(width: 80,child: Lottie.asset('assets/lottie/loading.json',)),
            ],
          ),
        ),
      ),
    );
  }
}
