import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class VBlancLoadingScreen extends StatelessWidget {
  const VBlancLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
        SizedBox(
          height: VSizes.buttonHeight,
          width: VSizes.buttonHeight,
          child: CircularProgressIndicator(strokeWidth: VSizes.strokeWidth,),
        )
        ,),
    );
  }
}
