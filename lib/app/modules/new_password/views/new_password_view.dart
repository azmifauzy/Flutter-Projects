import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GANTI PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            obscureText: true,
            controller: controller.password,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: "Password Baru : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                controller.ubahPassword();
              },
              child: Text("Ubah Password"))
        ],
      ),
    );
  }
}
