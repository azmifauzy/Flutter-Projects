import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/HomeWidget.dart';
import '../widgets/SearchWidget.dart';
import '../widgets/ReelsWidget.dart';
import '../widgets/ShopWidget.dart';
import '../widgets/ProfileWidget.dart';

class HomeController extends GetxController {
  RxInt indexWidget = 0.obs;
  void changeIndexBottomNav(int index) {
    indexWidget.value = index;
  }

  List<Widget> myWidgets = [
    HomeWidget(),
    SearchWidget(),
    ReelsWidget(),
    ShopWidget(),
    ProfileWidget(),
  ];
}
