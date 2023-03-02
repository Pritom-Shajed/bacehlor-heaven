import 'package:bachelor_heaven/constants/constants.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Selected selected = Selected.flat;

  void flatSelected() {
    selected = Selected.flat;
    update();
  }

  void roomSelected() {
    selected = Selected.room;
    update();
  }

  void seatSelected() {
    selected = Selected.seat;
    update();
  }
}
