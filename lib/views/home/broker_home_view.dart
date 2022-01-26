import 'package:dalal/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BrokerHomeView extends StatelessWidget {
  const BrokerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                "assets/broker_img.svg",
                height: Get.size.height/2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Get Daily Leads In Your City For Free",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .apply(fontWeightDelta: 1, color: MyColors.dark),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "We will reach you soon...\n For more info, contact our helpline number or consider visiting dalal.in ",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .apply(color: MyColors.dark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
