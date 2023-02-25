import 'package:bachelor_heaven/repository/landlord/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  UserRepository _userRepo = Get.put(UserRepository());

  User? _currentUser = FirebaseAuth.instance.currentUser;
  getUserData() {
    final _email = _currentUser?.email;

    if (_email != null) {
      return _userRepo.getUserDetails(_email);
    } else {
      Future.error('Error');
    }
  }
}
