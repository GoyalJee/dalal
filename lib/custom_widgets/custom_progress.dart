import 'package:dalal/constants/my_colors.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Container(
          height: 52,
          width: 52,
          decoration: const BoxDecoration(
              color: MyColors.light,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0, color: MyColors.dark,),
          ),
        ),
      ),
    );
  }
}
