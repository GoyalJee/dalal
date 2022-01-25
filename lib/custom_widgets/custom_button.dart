import 'package:dalal/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String btnText;
  final Color? bgColor;

  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.btnText,
      this.bgColor = MyColors.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        child: Center(child: Text(btnText)),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(Get.size.width, 48),
            primary: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Get.size.width / 2)))),
      ),
    );
  }
}
