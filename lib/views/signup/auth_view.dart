import 'package:dalal/controllers/signup/auth_controller.dart';
import 'package:dalal/custom_widgets/custom_button.dart';
import 'package:dalal/custom_widgets/custom_input.dart';
import 'package:dalal/custom_widgets/custom_progress.dart';
import 'package:dalal/views/signup/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Obx(() {
                        return Text(
                          "Welcome ${_controller.name.value}",
                          style: Theme.of(context).textTheme.headline5,
                        );
                      }),
                    ),
                  ),
                  CustomInput(
                    hint: "Name",
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    emptyError: "Please Enter Your Name.",
                    onChanged: (value) => _controller.name.value = value,
                    initialValue: _controller.name.value,
                  ),
                  CustomInput(
                    hint: "Phone Number",
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    maxLines: 1,
                    prefixText: "+91",
                    emptyError: "Please Enter Your Phone Number.",
                    onChanged: (value) => _controller.phoneNumber = value,
                    initialValue: _controller.phoneNumber,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Hero(
                  tag: "go",
                  child: CustomButton(
                    btnText: "GO",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_controller.phoneNumber.length == 10) {
                          _controller.showLoading.value = true;
                          await _controller.signInWithPhoneNumber();
                        } else {
                          Get.snackbar(
                              "Error", "Please Enter 10 digit Mobile Number.",
                              backgroundColor: Colors.red.withOpacity(0.7));
                        }
                      }
                    },
                  ),
                ),
              ),
              Obx(
                () {
                  return _controller.showLoading.value
                      ? const CustomProgress()
                      : const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
