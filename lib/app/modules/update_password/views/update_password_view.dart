import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UBAH PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            obscureText: true,
            autocorrect: false,
            controller: controller.currentPassword,
            decoration: InputDecoration(
                labelText: "Password Sebelumnya : ",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            autocorrect: false,
            controller: controller.newPassword,
            decoration: InputDecoration(
                labelText: "Password Baru : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            obscureText: true,
            autocorrect: false,
            controller: controller.newConfirmPassword,
            decoration: InputDecoration(
                labelText: "Konfirmasi Password Baru : ",
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await controller.update_password();
              },
              child: Text("Ubah Password"))
        ],
      ),
    );
  }
}
