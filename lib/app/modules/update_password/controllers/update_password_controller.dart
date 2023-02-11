import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> update_password() async {
    if (currentPassword.text.isNotEmpty &&
        newPassword.text.isNotEmpty &&
        newConfirmPassword.text.isNotEmpty) {
      isLoading.value = true;

      if (newPassword.text == newConfirmPassword.text) {
        try {
          await auth.signInWithEmailAndPassword(
              email: auth.currentUser!.email!, password: currentPassword.text);
          await auth.currentUser!.updatePassword(newPassword.text);

          Get.back();
          Get.snackbar("Berhasil.", "Berhasil mengubah password.");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Terjadi Kesalahan", "Password baru terlalu singkat.");
          } else if (e.code == 'email-already-in-use') {
            Get.snackbar("Terjadi Kesalahan", "Email telah digunakan.");
          } else if (e.code == 'wrong-password') {
            Get.snackbar("Terjadi Kesalahan", "Password Sebelumnya Salah.");
          } else {
            Get.snackbar("Terjadi Kesalahan", "${e.code}");
          }
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Terjadi Kesalahan",
            "Password Baru dan Konfirmasi Password tidak sama.");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Semua input harus diisi.");
    }
  }
}
