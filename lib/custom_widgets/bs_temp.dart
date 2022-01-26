import 'package:dalal/controllers/bs_temp_controller.dart';
import 'package:dalal/custom_widgets/custom_button.dart';
import 'package:dalal/custom_widgets/custom_progress.dart';
import 'package:dalal/views/home/user_home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BSTemp extends StatelessWidget {
  final String bs;

  BSTemp({Key? key, required this.bs}) : super(key: key);

  final _controller = Get.put(BSTempController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            Get.offAll(() => UserHomeView());
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 22, left: 18, bottom: 2),
                      child: Text("What do you want to $bs ?"),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Colors.white.withOpacity(0.6)),
                      child: Obx(() {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _controller.selectedVal.value,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 28,
                            ),
                            items: _controller.items
                                .map(_controller.buildMenuItem)
                                .toList(),
                            onChanged: (value) =>
                                _controller.selectedVal.value = value!,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 22, left: 18, bottom: 2),
                      child: Text("What is your budget ?"),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: Colors.white.withOpacity(0.6)),
                      child: Obx(
                        () {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _controller.budgetVal.value,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 28,
                              ),
                              items: _controller.budgetItems
                                  .map(_controller.buildMenuItem)
                                  .toList(),
                              onChanged: (value) =>
                                  _controller.budgetVal.value = value!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                  onTap: () {
                    _controller.showLoading.value = true;
                    _controller.bs = bs;
                    _controller.addDate();
                  },
                  btnText: "$bs Now"),
            ),
            Obx(() {
              return _controller.showLoading.value
                  ? const CustomProgress()
                  : const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
