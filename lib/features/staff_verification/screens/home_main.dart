import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/authentication/models/user_model.dart';
import 'package:staff_verify/features/staff_verification/controller/home_controller.dart';
import 'package:staff_verify/features/staff_verification/screens/history_tab.dart';
import 'package:staff_verify/features/staff_verification/screens/home_tab.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import '../../../data/repositories/user_repositories.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VHomeScreen extends StatefulWidget {
  const VHomeScreen({super.key});

  @override
  State<VHomeScreen> createState() => _VHomeScreenState();
}

final homeController = Get.put(VHomeController());
final userRepo = Get.find<VUserRepository>();

class _VHomeScreenState extends State<VHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return !homeController.hasFocus.value
            ? MaterialButton(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: context.theme.primaryColor,
                    ),
                    borderRadius: BorderRadiusDirectional.circular(
                      VSizes.mdBRadius,
                    )),
                onPressed: homeController.scanStaffQRCode,
                minWidth: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.qr_code_2),
                    SizedBox(
                      width: VSizes.smallSpace,
                    ),
                    Text("Scan QR Code", style: context.textTheme.labelLarge),
                  ],
                ))
            : IconButton(
                onPressed: homeController.scanStaffQRCode,
                icon: Icon(Icons.qr_code_scanner_sharp));
      }),
      appBar: AppBar(
        title: FittedBox(
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  VTexts.noPhotoIcon,
                  width: VSizes.appBarHeight * 0.4,
                ),
                SizedBox(
                  width: VSizes.spaceBtwItems,
                ),
                Text(
                  userRepo.currentUser.value != null
                      ? userRepo.currentUser.value!.username!
                      : '',
                  style: context.textTheme.displaySmall,
                ),
                SizedBox(
                  width: VSizes.smallSpace,
                ),
                Text(
                  userRepo.currentUser.value != null
                      ? VUserModel.roleEnumToString(userRepo.currentUser.value!.role)
                      : '',
                  style: context.textTheme.bodySmall!
                      .copyWith(color: context.theme.primaryColor),
                ),
              ],
            ),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              if(userRepo.currentUser.value?.role == VUserRole.admin)PopupMenuItem(
                  onTap: () => Get.toNamed(VRoutes.staffReg),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: VSizes.smallSpace,
                      ),
                      Text('Register Staff'),
                    ],
                  )),
              PopupMenuItem(
                  onTap: homeController.logout,
                  child: Row(
                    children: [
                      Icon(
                        Icons.login_outlined,
                        color: VColors.emphasis,
                      ),
                      SizedBox(
                        width: VSizes.smallSpace,
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(color: VColors.emphasis),
                      ),
                    ],
                  )),
            ],
            //position: PopupMenuPosition.under,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: VSpacingStyle.defaultPadding,
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
                    //onTap: (value) => homeController.toggleQRScanButton(value),
                    dividerColor: Colors.transparent,
                    labelStyle: context.textTheme.labelLarge!
                        .copyWith(color: VColors.whiteText),
                    unselectedLabelStyle: context.textTheme.labelLarge!
                        .copyWith(color: context.theme.primaryColor),
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadiusDirectional.circular(VSizes.mdBRadius),
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
                    VHomeTabView(
                      key: homeController.homeTabKey,
                      controller: homeController,
                    ),
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
