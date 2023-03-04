import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdsDetailsController extends GetxController{
  RxString checkInDate = ''.obs;
  RxString checkOutDate = ''.obs;

 formatCheckInDate(DateTime initialDate)async{
    checkInDate.value =
      DateFormat('yyyy-MM-dd').format(initialDate);
  }
  formatCheckOutDate(DateTime initialDate)async{
    checkOutDate.value =
        DateFormat('yyyy-MM-dd').format(initialDate);
  }

}