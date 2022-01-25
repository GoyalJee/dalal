import 'package:dalal/constants/my_colors.dart';
import 'package:dalal/controllers/user_controller.dart';
import 'package:dalal/custom_widgets/bs_temp.dart';
import 'package:dalal/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserHomeView extends StatelessWidget {
  UserHomeView({Key? key}) : super(key: key);

  final _controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_rounded,
          color: MyColors.dark,
        ),
        onPressed: () {
          Get.bottomSheet(
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Hero(
                      tag: "h",
                      child: CustomButton(
                          bgColor: Colors.green.withOpacity(0.7),
                          onTap: () {
                            Get.to(() => BSTemp(bs: "Buy"),
                                duration: const Duration(milliseconds: 700));
                          },
                          btnText: "Buy Plot/Building/etc.")),
                  CustomButton(
                      bgColor: Colors.red.withOpacity(0.7),
                      onTap: () {
                        Get.to(() => BSTemp(bs: "Sell"),
                            duration: const Duration(milliseconds: 700));
                      },
                      btnText: "Sell Plot/Building/etc."),
                ],
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/splash.png",
              height: AppBar().preferredSize.height,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _controller.users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  color: _controller.users[index].bs == "Buy"
                      ? Colors.green.withOpacity(0.7)
                      : Colors.red.withOpacity(0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          _controller.users[index].what!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          _controller.users[index].budget!,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .apply(fontWeightDelta: 1),
                        ),
                      ),
                      Row(
                        children: [
                          Chip(label: Text(_controller.users[index].status!)),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.more_horiz_rounded),
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Mark as Deal Completed",
                                    actions: [
                                      CustomButton(onTap: ()=>Get.back(), btnText: "No"),
                                      CustomButton(onTap: ()=>_controller, btnText: "Yes"),
                                    ],
                                    content: null);
                              },
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
