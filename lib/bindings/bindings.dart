import 'package:bachelor_heaven/controller/auth/auth_controller.dart';
import 'package:bachelor_heaven/controller/dashboard/home_controller.dart';
import 'package:bachelor_heaven/controller/intial/bottom_nav_controller.dart';
import 'package:bachelor_heaven/controller/dashboard/category_controller.dart';
import 'package:bachelor_heaven/controller/landlord/post_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
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

class PostAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
