import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? phoneNumber;
  String? bs;
  String? what;
  String? budget;
  String? status;

  UserModel(
      {required this.name,
      required this.phoneNumber,
      required this.bs,
      required this.what,
      required this.budget,
      required this.status});

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    UserModel userModel = UserModel(
        name: snapshot['name'],
        phoneNumber: snapshot['phone'],
        bs: snapshot['bs'],
        what: snapshot['what'],
        budget: snapshot['budget'],
        status: snapshot['status']);

    return userModel;
  }
}
