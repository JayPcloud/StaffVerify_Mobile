import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_verify/data/services/qr_code_service.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import '../../../data/services/firebase_services/firestore_db/staff_repositories.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/device.dart';
import '../../staff_verification/models/staff_model.dart';
import '../components/staffInfo_tile.dart';
import '../controller/reg_confirmation_controller.dart';

class VRegConfirmationScreen extends StatelessWidget {
  const VRegConfirmationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final String staffId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: Get.back, icon: const Icon(Icons.arrow_back_outlined)),
        title: Text('Registration Details', style: context.textTheme.displaySmall),
      ),
      body: FutureBuilder(
        future: VStaffRepositories().getStaff(VTexts.staffIDField, staffId),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final Staff staff = Staff.fromJson(snapshot.data![0].data());
            final controller = Get.put(VRegConfirmationController(staff: staff));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: VSizes.defaultSpace),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius:
                          BorderRadiusDirectional.circular(VSizes.mdBRadius),
                          child: Image.network(
                            staff.imageUrl!,
                            height: VDeviceUtils.screenWidth * 0.2,
                            width: VDeviceUtils.screenWidth * 0.2,
                            fit: BoxFit.cover,
                          )
                      ),
                      SizedBox(width: VSizes.spaceBtwItems,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${staff.firstname} ${staff.lastname}',
                            style: GoogleFonts.merriweather(
                                textStyle: context.textTheme.displaySmall
                            ),
                          ),

                          Text(staff.role??'Staff Member', style: context.textTheme.bodyMedium ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: VSizes.defaultSpace,),
                StaffInfoTile(title: 'Staff ID', trailing: staff.staffID!),
                StaffInfoTile(title: 'Email', trailing: staff.email!),
                StaffInfoTile(title: 'Phone No.', trailing: staff.mobileNo!),
                StaffInfoTile(title: 'Department', trailing: staff.department!),
                SizedBox(height: VSizes.spaceBtwSections,),
                Material(
                  elevation: VSizes.elevation,
                  borderRadius: BorderRadiusDirectional.circular(VSizes.mdBRadius),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: VSizes.defaultSpace, horizontal: VSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        Text("Staff QR-Code", style: context.textTheme.displaySmall,),
                        SizedBox(height: VSizes.spaceBtwItems,),
                        VQRCodeGenerator(qrData: staff.staffID!).toImageWidget(key: GlobalKey() ),
                        SizedBox(height: VSizes.defaultSpace,),
                        MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(VSizes.smallBRadius,),side: BorderSide(color: context.theme.primaryColor)),
                          onPressed: controller.savePdf,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Download"),
                              SizedBox(width: VSizes.smallSpace,),
                              Obx(()=> controller.generatingPdf.value?
                              SizedBox(
                                width: VSizes.buttonHeight,
                                height: VSizes.buttonHeight,
                                child: CircularProgressIndicator(strokeWidth: VSizes.strokeWidth,),):
                              Icon(Icons.download_outlined)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            );
          }else if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError) {
            return Text("Registration Failed. Please Try again later or contact the support team for assistance");
          }else{
            return Text("No data");
          }
        },
      ),
    );
  }


}

