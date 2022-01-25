import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? phoneNumber;
  String? bs;
  String? what;
  String? budget;
  String? status;


  UserModel(this.name, this.phoneNumber, this.bs, this.what, this.budget,
      this.status);

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    name = documentSnapshot['name'];
    phoneNumber = documentSnapshot['phoneNumber'];
    bs = documentSnapshot['bs'];
    what = documentSnapshot['what'];
    budget = documentSnapshot['budget'];
    status = documentSnapshot['status'];
  }
}