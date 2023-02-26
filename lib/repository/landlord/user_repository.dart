import 'package:bachelor_heaven/model/landlord/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser;

  // Future<UserModel> getUserDetails(String uid) async {
  //   final snapshot =
  //       await _firestore.collection('users').where('uid', isEqualTo: uid).get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).single;

  //   return userData;
  // }

  // Future<List<UserModel>> getAllUserDetails(String uid) async {
  //   final snapshot = await _firestore.collection('users').get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).toList();

  //   return userData;
  // }

  updateUserDetails(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(_currentUser!.uid)
        .update(user.toJson())
        .then((value) => Get.back())
        .then((value) => Get.back())
        .then((value) => Fluttertoast.showToast(msg: 'Successfully updated'));
  }
}
