import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEC2020),
        body: Center(
          child: Container(
            width: Get.width * 0.5,
            height: Get.width * 0.5,
            child: Image.network(
                "https://github.com/kuldii/mytsel/blob/main/assets/logo/logo-splash.png?raw=true"),
          ),
        ),
      ),
    );
  }
}
