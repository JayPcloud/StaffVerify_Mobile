import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';

class InternetAccessTracker extends GetxController {
  @override
  void onInit() {
    bool firstTimeCheck = true;
    connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        firstTimeCheck = false;
        hasNetworkConnection = false;

        VHelperFunc.snackBarNotifier(
            msg: "No Network Connection",
            txtColor: VColors.errorText,
            showIcon: true,
            colorOpacity: 0.9,
            );
      } else {
        if (!firstTimeCheck) {
          hasNetworkConnection = true;
          VHelperFunc.snackBarNotifier(
              msg: "Connected",
              txtColor: Colors.green,
              showIcon: true,
              colorOpacity: 0.9,
              icon: Icon(
                Icons.wifi,
                color: Colors.green,
              )
          );
        }
      }
    });
    // connectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
    //     if (status == InternetConnectionStatus.connected) {
    //       if(!firstTimeCheck) {
    //         hasInternetAccess = true;
    //         VHelperFunc.snackBarNotifier(msg: "Connected to the internet");
    //       }
    //     } else {
    //       firstTimeCheck = false;
    //       hasInternetAccess = false;
    //       VHelperFunc.snackBarNotifier(msg: "No Internet Access", txtColor: VColors.errorText);
    //     }
    //   },

    super.onInit();
  }

  // final connectionChecker = InternetConnectionChecker.instance;
  // static late bool hasInternetAccess;

  final connectivity = Connectivity();

  static late bool hasNetworkConnection;
}
