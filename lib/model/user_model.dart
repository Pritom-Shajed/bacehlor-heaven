import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? profilePic;
  String? uid;
  String? location;
  String? joinedDate;

  UserModel({
    required this.name,
    required this.email,
    this.profilePic,
    required this.uid,
    required this.location,
    required this.joinedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
      'location': location,
      'joinedDate': joinedDate
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        profilePic: snapshot['profilePic'],
        uid: snapshot['uid'],
        location: snapshot['location'],
        joinedDate: snapshot['joinedDate']);
  }
}
