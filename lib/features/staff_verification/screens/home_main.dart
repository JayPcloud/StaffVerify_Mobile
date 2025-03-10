import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/controller/history_controller.dart';
import 'package:staff_verify/features/staff_verification/controller/home_controller.dart';
import 'package:staff_verify/features/staff_verification/screens/history_tab.dart';
import 'package:staff_verify/features/staff_verification/screens/home_tab.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VHomeScreen extends StatelessWidget {
  const VHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(VHomeController());
    final historyController = Get.put(VHistoryController());
    return Scaffold(
      body: Padding(
        padding: VSpacingStyle.paddingWithAppBarHeight.copyWith(bottom: 0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Material(
                elevation: VSizes.elevationSm,
                borderRadius:
                    BorderRadiusDirectional.circular(VSizes.mdBRadius),
                child: Container(
                  height: VSizes.tabHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    labelStyle:context.textTheme.labelLarge!.copyWith(color: VColors.whiteText),
                    unselectedLabelStyle:context.textTheme.labelLarge!.copyWith(color:context.theme.primaryColor ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(VSizes.mdBRadius),
                      color: context.theme.primaryColor,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Text("Home"),
                      Text("History"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    VHomeTabView(controller: homeController,),
                    VHistoryTabView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
