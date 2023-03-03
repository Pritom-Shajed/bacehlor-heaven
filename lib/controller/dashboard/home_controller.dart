import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString searchName = ''.obs;
  RxString allAdsUid = ''.obs;


  void updateSliderIndex(int index) {
    currentIndex.value = index;
  }

  void searchByCity(String value) {
    searchName.value = value;
  }

}
