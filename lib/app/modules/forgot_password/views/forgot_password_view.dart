import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
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
          Obx(
            () => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.forgot_password();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "RESET PASSWORD"
                    : "LOADING...")),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(onPressed: () {}, child: Text("Masuk"))
        ],
      ),
    );
  }
}
