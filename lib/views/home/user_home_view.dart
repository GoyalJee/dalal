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
              Wrap(
                children: [
                  Container(
                    margin: const EdgeInsets.all(2),
                    child: const Center(child: Text("hlo", style: TextStyle(color: Colors.white),)),
                  ),
                  CustomButton(
                      bgColor: Colors.green.withOpacity(0.7),
                      onTap: () {
                        Get.offAll(() => BSTemp(bs: "Buy"));
                      },
                      btnText: "Buy Plot/Building/etc."),
                  CustomButton(
                      bgColor: Colors.red.withOpacity(0.7),
                      onTap: () {
                        Get.offAll(() => BSTemp(bs: "Sell"));
                      },
                      btnText: "Sell Plot/Building/etc."),
                  Container(
                    margin: const EdgeInsets.all(2),
                    child: const Center(child: Text("hlo", style: TextStyle(color: Colors.white),)),
                  ),
                ],
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(22))),
              barrierColor: Colors.black54,
              backgroundColor: Colors.white);
        },
      ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxScroll) => [
            SliverAppBar(
              elevation: 0,
              floating: true,
              automaticallyImplyLeading: false,
              snap: true,
              pinned: true,
              title: Image.asset(
                "assets/splash.png",
                height: AppBar().preferredSize.height,
              ),
              centerTitle: true,
              forceElevated: innerBoxScroll,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            )
          ],
          body: SafeArea(
            child: Obx(() {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.userList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      tileColor: _controller.userList[index].bs == "Buy"
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22))),
                      title: Text(_controller.userList[index].budget!),
                      subtitle: Text(_controller.userList[index].what!),
                      trailing: Chip(
                          label: Text(_controller.userList[index].status!)),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
