import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> forgot_password() async {
    if (email.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: email.text);
        Get.defaultDialog(
            title: "Berhasil!",
            middleText:
                "Berhasil mengirim email reset password, silahkan cek email kamu.",
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Text("Tutup"))
            ]);
      } catch (e) {
        Get.snackbar(
            "Terjadi Kesalahan", "Tidak dapat mengirim email reset password.");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
