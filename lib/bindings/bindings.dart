import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/controller/booking/booking_controller.dart';
import 'package:bachelor_heaven/controller/dashboard/home_controller.dart';
import 'package:bachelor_heaven/controller/intial/dashboard_controller.dart';
import 'package:bachelor_heaven/controller/dashboard/category_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(CategoryController());
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(BookingController());
  }
}
