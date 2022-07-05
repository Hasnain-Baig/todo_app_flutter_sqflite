import 'dart:async';
import 'package:crud_flutter_local_database/main.dart';
import 'package:crud_flutter_local_database/screens/todos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void onInit() {
    super.onInit();
    timerPlay();
  }

  late int _myTimer = 0;
  int get myTimer => _myTimer;

  timerPlay() {
    var _splashScreenTimer;
    _splashScreenTimer =
        new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
      _myTimer++;
      if (_myTimer == 3) {
        _splashScreenTimer.cancel();
        Get.to(
            WillPopScope(onWillPop: () async => false, child: TodosScreen()));
      }
    });
  }
}
