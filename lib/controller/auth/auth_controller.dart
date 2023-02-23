import 'dart:io';
import 'package:bachelor_heaven/constants/constants.dart';
import 'package:bachelor_heaven/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  File? image;
  pickImage(ImageSource src) async {
    XFile? xfile = await ImagePicker().pickImage(source: src);
    if (xfile != null) {
      image = File(xfile.path);
      update();
    }
  }

  // uploadImage({required String uid, required File img}) async {
  //   try {
  //     Reference ref =
  //         FirebaseStorage.instance.ref().child('profile-pic').child(uid);

  //     TaskSnapshot taskSnapshot = await ref.putFile(img);

  //     String profilePicUrl = await taskSnapshot.ref.getDownloadURL();
  //     update();
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar(
  //         'Error Occured!', 'Error uploading your picture, kindly try again',
  //         duration: Duration(seconds: 2));
  //   }
  // }

  signUp({
    required String email,
    required String pass,
    required String name,
    required String location,
  }) async {
    try {
      if (image != null) {
        Fluttertoast.showToast(
            msg: 'Creating account for $name...',
            toastLength: Toast.LENGTH_SHORT);

        //Sign in
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        //Upload Image
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('profile-pic')
            .child('user_${credential.user!.uid}');

        TaskSnapshot taskSnapshot = await ref.putFile(image!);

        String profilePicUrl = await taskSnapshot.ref.getDownloadURL();

        //Storing informations
        UserModel user = UserModel(
            name: name,
            email: email,
            uid: credential.user!.uid,
            profilePic: profilePicUrl,
            location: location,
            joinedDate: currentDate);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        Get.snackbar(
            'Successfully Registered', 'Hi $name, Welcome to Bachelor Heaven.',
            duration: Duration(seconds: 2));
        Get.offAllNamed('/nav_panel');
      } else {
        Fluttertoast.showToast(msg: 'Please select your profile picture');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for $email.');
      }
    } catch (e) {
      Get.snackbar('Error Occured', 'Please try again',
          duration: Duration(seconds: 2));
      print(e);
    }
  }

  singIn({required String email, required String pass}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      Get.snackbar('Logged In', 'Welcome to Bachelor Heaven.',
          duration: Duration(seconds: 2));
      Get.offAllNamed('/nav_panel');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for $email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for $email.');
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/nav_panel');
    Get.snackbar('Logged out', 'Hope to see you soon.',
        duration: Duration(seconds: 2));
  }
}
