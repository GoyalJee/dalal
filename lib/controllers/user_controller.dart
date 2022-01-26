import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final userList = <UserModel>[].obs;

  Stream<List<UserModel>> getUserListings() {
    return FirebaseFirestore.instance
        .collection('bs')
        .where('phone', isEqualTo: GetStorage().read("phone"))
        .snapshots()
        .map((event) {
      return event.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    });
  }

  @override
  void onInit() {
    userList.bindStream(getUserListings());
    super.onInit();
  }
}
