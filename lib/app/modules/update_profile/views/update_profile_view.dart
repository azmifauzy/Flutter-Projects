import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nip.text = user["nip"];
    controller.nama.text = user["nama"];
    controller.email.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: Text('UBAH PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["image"] != null) {
                      return ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            user["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "https://ui-avatars.com/api/?background=random&&name=${user["nama"].toLowerCase()}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.pick_image();
                      },
                      child: Text(
                        "Ganti",
                      )),
                  if (user["image"] != null) Text("|"),
                  if (user["image"] != null)
                    TextButton(
                        onPressed: () {
                          controller.delete_image(user["uid"]);
                        },
                        child: Text(
                          "Hapus",
                        )),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.email,
            decoration: InputDecoration(
                labelText: "Email : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nip,
            decoration: InputDecoration(
                labelText: "NIP : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nama,
            decoration: InputDecoration(
                labelText: "Nama : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await controller.update_profile(user["uid"]);
              },
              child: Text("Ubah Profile"))
        ],
      ),
    );
  }
}
