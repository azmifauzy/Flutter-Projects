import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var checkC = false.obs;
  TextEditingController phone_controller = TextEditingController();

  @override
  void onClose() {
    phone_controller.dispose();
    super.onClose();
  }
}
