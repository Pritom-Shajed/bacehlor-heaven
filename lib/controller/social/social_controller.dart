import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialController extends GetxController{
  phoneCall({required String phoneNumber})async{
    final Uri phone = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if(await canLaunchUrl(phone)){
      launchUrl(phone);
    } else {
      Fluttertoast.showToast(msg: 'Error Occured');
    }
  }
}