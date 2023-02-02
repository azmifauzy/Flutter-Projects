import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import 'package:flutter/src/material/icons.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
          () => controller.myWidgets.elementAt(controller.indexWidget.value)),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => controller.changeIndexBottomNav(value),
          items: [
            BottomNavigationBarItem(
                label: "Title",
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "Title",
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "Title",
                icon: Icon(
                  Icons.video_collection_outlined,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "Title",
                icon: Icon(
                  Icons.shop_outlined,
                  color: Colors.black,
                )),
            BottomNavigationBarItem(
                label: "TItle",
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.black,
                ))
          ]),
    );
  }
}
