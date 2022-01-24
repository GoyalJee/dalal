import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal/views/home/home_view.dart';
import 'package:dalal/views/signup/auth_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  String _verificationId = '';
  var phoneNumber = "";
  var type = "";
  var name = "".obs;
  var showLoading = false.obs;

  var otp = "";
  var otpDescText =
      "To Verify This Phone Number Belongs To You, Please Enter The OTP That We Send On This Number.";

  isNumberExist() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.phoneNumber.toString())
        .get()
        .then((value) {
      if (value.exists) {
        GetStorage().write('isOnBoardingScreenShowed', 'true');
        Get.off(() => HomeView());
        Get.snackbar(
          "Hey🖐🏽🖐🏽",
          "Welcome Back !",
        );
      } else {
        uploadToDB();
      }
    });
  }

  Future<void> uploadToDB() async {
    showLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.phoneNumber.toString())
          .set({"name": name.value, "type": type});
      GetStorage().write('isOnBoardingScreenShowed', 'true');
      Get.off(() => HomeView());
      Get.snackbar("Hey🖐🏽🖐🏽", "Successfully SignedIn !!",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(),);
      showLoading.value = false;
    }
  }

  Future<void> verifyNumber() async {
    await auth.verifyPhoneNumber(
      autoRetrievedSmsCodeForTesting: "123456",
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        isNumberExist();
      },
      verificationFailed: (FirebaseAuthException e) {
        showLoading.value = false;
        Get.off(() => AuthView());
        Get.snackbar(e.code, "${e.message}",
            backgroundColor: Colors.red.withOpacity(0.7));
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        Get.snackbar("TimeOut",
            "You have only 60 seconds to enter the otp. Please Retry.. ",
            backgroundColor: Colors.red.withOpacity(0.7));
        Get.off(() => AuthView());
      },
    );
  }

  signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      await auth.signInWithCredential(credential);
      isNumberExist();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red.withOpacity(0.7),
      );
    }
  }
}
