import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';

class VImageSourceDialog extends StatelessWidget {
  const VImageSourceDialog({
    super.key, this.gallerySelect, this.cameraSelect
  });

  final void Function()? gallerySelect;
  final void Function()? cameraSelect;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.bottomCenter,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(VSizes.defaultSpace),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(VSizes.lBRadius)),
        title: Text("Select Image Source", style: context.textTheme.displaySmall,),
        content: Row(children:[
          imageSourceSelector(context, title: 'Camera', icon: Icons.camera_alt,onPressed: cameraSelect),
          SizedBox(width: VSizes.spaceBtwSections,),
          imageSourceSelector(context, title: 'Gallery', icon: FontAwesomeIcons.images, onPressed: gallerySelect),
        ]),

      ),
    );
  }

  Column imageSourceSelector(BuildContext context,
      {required String title, required IconData icon, required void Function()? onPressed}) {
    return Column(children:[
          MaterialButton(
            padding: EdgeInsets.all(VSizes.defaultSpace),
            onPressed: onPressed,
            minWidth: 0,
            color: context.theme.primaryColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(VSizes.defaultSpace),
              side: BorderSide(color: context.theme.colorScheme.surface, width: VSizes.borderWidth0),
            ),
            child: Icon(icon, ),
          ),
          SizedBox(height: VSizes.smallSpace,),
          Text(title, style: context.textTheme.bodyMedium,),
        ]);
  }
}


