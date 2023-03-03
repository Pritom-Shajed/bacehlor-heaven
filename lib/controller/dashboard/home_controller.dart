import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString searchName = ''.obs;

  void updateSliderIndex(int index) {
    currentIndex.value = index;
  }

  void searchByCity(String value) {
    searchName.value = value;
  }
}
