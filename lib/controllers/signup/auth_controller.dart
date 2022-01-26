import 'package:dalal/views/home/broker_home_view.dart';
import 'package:dalal/views/home/user_home_view.dart';
import 'package:dalal/views/signup/otp_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var verificationId = '1'.obs;
  var phoneNumber = "";
  var type = "";
  var name = "".obs;
  var showLoading = false.obs;

  String get veri_result => verificationId.value;

  var otp = "";
  var otpDescText =
      "To Verify This Phone Number Belongs To You, Please Enter The OTP That We Send On This Number.";

  storeCred() {
    try {
      GetStorage().write("name", name.value);
      GetStorage().write("phone", phoneNumber);
      GetStorage().write("type", type);
      GetStorage().write("isOnBoardingScreenShowed", "true");
      if (type == "user") {
        Get.off(() => UserHomeView());
        Get.snackbar("Hey 🖐🏽🖐🏽", "SignedIn Successfully !");
      } else {
        Get.off(() => BrokerHomeView());
        Get.snackbar("Hey 🖐🏽🖐🏽", "SignedIn Successfully !");
      }
    } catch (e) {
      showLoading.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red.withOpacity(0.7));
    }
  }

  signInWithPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        storeCred();
      },
      verificationFailed: (FirebaseException e) {
        showLoading.value = false;
        Get.snackbar(
          "Error",
          e.toString(),
          backgroundColor: Colors.red.withOpacity(0.7),
        );
      },
      codeSent: (String verificationID, int? responseToken) {
        Get.off(() => OTPAuthView());
        showLoading.value = false;
        verificationId.value = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  myCredentials({required String verID}) {
    AuthCredential authCredential =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
    FirebaseAuth.instance.signInWithCredential(authCredential).then((value) {
      storeCred();
    }).catchError((e) {
      showLoading.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red.withOpacity(0.7));
    });
  }
}
