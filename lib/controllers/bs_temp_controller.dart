import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalal/views/home/user_home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BSTempController {
  var selectedVal = "Personal Plot".obs;
  var budgetVal = "Less than 10 Lakhs".obs;
  var showLoading = false.obs;
  var bs;
  var status = 'new';
  var phone = GetStorage().read("phone");
  var name = GetStorage().read("name");
  var docId = FirebaseAuth.instance.currentUser!.uid;

  addDate() async {
    try {
      await FirebaseFirestore.instance.collection('bs').add({
        "name": name,
        "phone": phone,
        "bs": bs,
        "what": selectedVal.value,
        "budget": budgetVal.value,
        "status": status,
      });
      showLoading.value = false;
      Get.off(() => UserHomeView());
      Get.defaultDialog(
          title: "Dalal",
          textCancel: "OK",
          content: const Center(
              child:
                  Text("Our trusted agents will contact you within 24 hours.")),
          barrierDismissible: false);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red.withOpacity(0.7));
    }
  }

  // List of items in our dropdown menu
  final items = [
    'Personal Plot',
    'Personal Home/Flat/etc.',
    'Commercial Building',
    'Commercial Land',
  ];

  // List of items in our dropdown menu
  final budgetItems = [
    'Less than 10 Lakhs',
    '10-40 Lakhs',
    '40-100 Lakhs',
    'More than 100 Lakhs',
  ];

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
}
