import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "TODO APP",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "(sqflite)",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          // fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  )),
                ),
                Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "By Hasnain",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
