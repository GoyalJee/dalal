import 'package:dalal/constants/my_colors.dart';
import 'package:dalal/controllers/signup/auth_controller.dart';
import 'package:dalal/custom_widgets/custom_button.dart';
import 'package:dalal/custom_widgets/custom_progress.dart';
import 'package:dalal/views/signup/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhoView extends StatelessWidget {
  WhoView({Key? key}) : super(key: key);

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Hey,",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .apply(color: MyColors.dark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "What describes you best ?",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .apply(fontWeightDelta: 2, color: MyColors.dark),
              ),
            ),
            SizedBox(height: Get.size.height / 5),
            CustomButton(
                onTap: () {
                  _controller.type = "user";
                  Get.to(()=>AuthView());
                },
                btnText: "I Waana Buy or Sell Plot/Building."),
            CustomButton(
                onTap: () {
                  _controller.type = "broker";
                  Get.to(()=>AuthView());
                },
                btnText: "I am a Property Dealer."),
          ],
        )
      ),
    );
  }
}
