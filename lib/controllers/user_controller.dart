import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  Rx<List<UserModel>> userList = Rx<List<UserModel>>([]);

  List<UserModel> get users => userList.value;

  @override
  void onReady() {
    super.onReady();
    userStream();
  }

  static Stream<List<UserModel>> userStream() {
    return FirebaseFirestore.instance
        .collection('bs')
        .where('phoneNumber', isEqualTo: GetStorage().read("phone"))
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> users = [];
      for (var user in query.docs) {
        final userModel =
            UserModel.fromDocumentSnapshot(documentSnapshot: user);
        users.add(userModel);
      }
      return users;
    });
  }

}
