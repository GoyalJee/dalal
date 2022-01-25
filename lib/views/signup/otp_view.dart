import 'package:dalal/controllers/signup/auth_controller.dart';
import 'package:dalal/custom_widgets/custom_button.dart';
import 'package:dalal/custom_widgets/custom_input.dart';
import 'package:dalal/custom_widgets/custom_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPAuthView extends StatelessWidget {
  OTPAuthView({Key? key}) : super(key: key);

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
              Column(
                children: [
                  CustomInput(
                    hint: "OTP",
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    maxLines: 1,
                    emptyError: "Please Enter OTP.",
                    onChanged: (value) => _controller.otp = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.5),
                    child: Text(
                      _controller.otpDescText,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Hero(
                  tag: "go",
                  child: CustomButton(
                    btnText: "GO",
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        _controller.showLoading.value = true;
                        _controller.myCredentials(verID: _controller.veri_result);
                      }
                    },
                  ),
                ),
              ),
              Obx(() {
                return _controller.showLoading.value
                    ? const CustomProgress()
                    : const SizedBox.shrink();
              },)
            ],
          ),
        ),
      ),
    );
  }
}
