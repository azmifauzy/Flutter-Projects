import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presenceapp/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masuk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.email,
            decoration: InputDecoration(
                labelText: "Email : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            autocorrect: false,
            controller: controller.password,
            decoration: InputDecoration(
                labelText: "Password : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.login();
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "MASUK" : "LOADING...")),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
              child: Text("Lupa Password"))
        ],
      ),
    );
  }
}
