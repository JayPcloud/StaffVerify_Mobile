import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/common/widgets/action_button.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class VUtilsComponents {

  static PopScope fullScreenLoader(String? action) {
    return PopScope(
      canPop: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            color: Get.context!.theme.primaryColor,
          ),
          SizedBox(height: VSizes.defaultSpace,),
          Text(
            action??'',
            style: Get.context!.textTheme.labelSmall,
          )
        ],
      ),
    );
  }

  static Widget actionLoader(String action) {
    return PopScope(
      canPop: false,
      child: FittedBox(
        child: AlertDialog(
          contentPadding: EdgeInsets.all(VSizes.spaceBtwSections),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(VSizes.mdBRadius)),
          content: Row(children:[
            Text(action, style: Get.context!.textTheme.headlineSmall!.copyWith(fontSize: VSizes.fontSizeMd),),
            Spacer(),
            SizedBox(
              height: VSizes.buttonHeight,
              width: VSizes.buttonHeight,
              child:  CircularProgressIndicator(
                strokeWidth: VSizes.strokeWidth,
                color: Get.context!.theme.primaryColor,
              ),
            )
          ]),

        ),
      ),
    );
  }

  static Widget confirmationDialog({String? title, String? option2, String? option1,
    required String confirmMessage, required void Function()? onPressed1, required void Function()? onPressed2 }) {
    return FittedBox(
      child: AlertDialog(
        title: title != null?Text(title, style: Get.context!.textTheme.displaySmall,):null,
        contentPadding: EdgeInsets.all(VSizes.defaultSpace),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(VSizes.mdBRadius)),
        content: Column(
          children: [
            Text(confirmMessage, style: Get.context!.textTheme.headlineSmall,maxLines: 10,),
            SizedBox(height: VSizes.defaultSpace,),
            Row(children:[
              MaterialButton(
                shape: RoundedRectangleBorder(side: BorderSide(color: VColors.emphasis,),borderRadius: BorderRadiusDirectional.circular(VSizes.smallBRadius)),
                onPressed: onPressed1,child: Text(option1??'Cancel', style: Get.context!.textTheme.headlineSmall!.copyWith(color: VColors.emphasis),),),
              Spacer(),

              VActionButton(actionText: option2??'Continue',minWidth: 0, onPressed: onPressed2,radius: VSizes.smallBRadius,),

            ]),
          ],
        ),

      ),
    );
  }


  static GetSnackBar errorSnackBarNotifier(String err, SnackPosition? position) {
    return GetSnackBar(
      snackPosition: position??SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      animationDuration: Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      borderRadius: VSizes.microBRadius,
      backgroundColor: Get.context!.theme.primaryColor.withOpacity(0.8),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      messageText: Text(
        err,
        style: Get.context!.textTheme.labelSmall!
            .copyWith(color: VColors.errorText,fontWeight: FontWeight.normal),
      ),
    );
  }

  static GetSnackBar snackBarNotifier({required String msg, SnackPosition? position, Color? txtColor}) {
    return GetSnackBar(
      snackPosition: position??SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 500),
      dismissDirection: DismissDirection.horizontal,
      borderRadius: VSizes.smallBRadius,
      backgroundColor: Get.context!.theme.primaryColor.withOpacity(0.5),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      messageText: Center(
        child: Text(
          msg,
          style: Get.context!.textTheme.labelSmall!
              .copyWith(color:txtColor??VColors.darkText,fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}