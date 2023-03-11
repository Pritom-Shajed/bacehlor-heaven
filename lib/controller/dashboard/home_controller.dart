import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final _currentIndex = 0.obs;
  RxString searchName = ''.obs;
  RxString allAdsUid = ''.obs;

  get currentIndex => _currentIndex;

  set currentIndex(value) {
      _currentIndex.value = value;
  }

  void updateSliderIndex(int index) {
    currentIndex = index;
  }

  void searchByCity(String value) {
    searchName.value = value;
  }

}
