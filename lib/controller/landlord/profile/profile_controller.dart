import 'package:bachelor_heaven/model/landlord/user_model.dart';
import 'package:bachelor_heaven/repository/landlord/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  UserRepository _userRepo = Get.put(UserRepository());

  // User? _currentUser = FirebaseAuth.instance.currentUser;

  // getUserData() {
  //   final _uid = _currentUser?.uid;

  //   if (_uid != null) {
  //     return _userRepo.getUserDetails(_uid);
  //   } else {
  //     Future.error('Error');
  //   }
  // }

  updateUserData(UserModel user) async {
    await _userRepo.updateUserDetails(user);
  }
}
