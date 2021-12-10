import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? emailAddress;
  final String? password;
  final String? userUid;
  final String? userImage;

  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.userUid,
    required this.userImage,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      fullName: doc['FullName'],
      emailAddress: doc['emailAddress'],
      userImage: doc['imageUrl'],
      password: doc['password'],
      userUid: doc['userUid'],
    );
  }
}
