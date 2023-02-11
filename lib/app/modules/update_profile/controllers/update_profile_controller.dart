import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nip = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  XFile? image;
  void pick_image() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void delete_image(String uid) async {
    Get.defaultDialog(
        title: "Kamu Yakin?",
        middleText: "ingin menghapus foto profil?",
        actions: [
          OutlinedButton(onPressed: () => Get.back(), child: Text("Batal")),
          ElevatedButton(
              onPressed: () async {
                try {
                  await firestore.collection("pegawai").doc(uid).update({
                    "image": FieldValue.delete(),
                  });
                  Get.back();
                  Get.back();
                  Get.snackbar("Berhasil.", "Berhasil menghapus profil.");
                } catch (e) {
                  Get.snackbar(
                      "Terjadi Kesalahan.", "Tidak dapat menghapus foto.");
                } finally {
                  update();
                }
              },
              child: Text("Iya")),
        ]);
  }

  Future<void> update_profile(String uid) async {
    if (nama.text.isNotEmpty && nip.text.isNotEmpty && email.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "nip": nip.text,
          "nama": nama.text,
        };

        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref("$uid/profile.$ext").putFile(file);

          String urlImage =
              await storage.ref("$uid/profile.$ext").getDownloadURL();

          data.addAll({"image": urlImage});
        }
        await firestore.collection("pegawai").doc(uid).update(data);
        image = null;
        Get.back();
        Get.snackbar("Berhasil.", "Berhasil mengubah profil.");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi beberapa saat.");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Nama, NIP, dan Email harus diisi.");
    }
  }
}
