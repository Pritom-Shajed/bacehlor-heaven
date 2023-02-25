import 'package:bachelor_heaven/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).single;

    return userData;
  }

  Future<List<UserModel>> getAllUserDetails(String email) async {
    final snapshot = await _firestore.collection('users').get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnap(e)).toList();

    return userData;
  }
}
