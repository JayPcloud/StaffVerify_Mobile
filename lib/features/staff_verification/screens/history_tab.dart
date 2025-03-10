import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/components/verificationHistory_tile.dart';
import 'package:staff_verify/features/staff_verification/controller/history_controller.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import '../../../utils/constants/sizes.dart';

class VHistoryTabView extends StatelessWidget {
   VHistoryTabView({super.key,});

  final controller = Get.put(VHistoryController());

  @override
  Widget build(BuildContext context) {

    return PopScope(
      child: Obx(
        () {

          if(controller.initializing){
            return Center(child: CircularProgressIndicator(),);
          }

          if(!controller.initializing && controller.histories.isEmpty) {
            return Center(child: Text("No Verifications made yet"),);
          }

          return SingleChildScrollView(
              controller: controller.scrollController,
              child: Padding(
                padding: VSpacingStyle.paddingWithAppBarHeight
                    .copyWith(top: VSizes.spaceBtwSections),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verification History",
                      style: context.textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: VSizes.spaceBtwSections,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.histories.length,
                        itemBuilder: (context, index) {
                          final history = VHistoryModel.fromJson(controller.histories[index] as DocumentSnapshot<Map<String, dynamic>> );
                          return VHistoryTile(
                            history: VHistoryModel(
                                verificationStatus: history.verificationStatus,
                                vMethod: history.vMethod,
                                vid: history.vid,
                                timestamp: history.timestamp),
                          );
                        }
                    ),

                    if(controller.isLoadingMore.value) Padding(
                      padding: const EdgeInsets.symmetric(vertical: VSizes.smallSpace),
                      child: Center(child: Text("Loading more...")),
                    )
                  ],
                ),
              ),
            );
        }
      ),
    );
  }
}
