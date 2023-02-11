import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presenceapp/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        // CEK VERIFY EMAIL
        if (credential.user != null) {
          if (credential.user!.emailVerified == true) {
            isLoading.value = false;
            Get.offAllNamed(Routes.HOME);
            password.text == "password"
                ? Get.offAllNamed(Routes.NEW_PASSWORD)
                : Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
                title: "Email belum diverifikasi.",
                middleText:
                    "Email belum diverifikasi, silahkan cek email kamu.",
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await credential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar("Berhasil",
                              "Berhasil mengirim email verifikasi, silahkan cek email kamu.");
                        } catch (e) {
                          Get.snackbar("Terjadi Kesalahan",
                              "Tidak dapat mengirim email verifikasi, coba lagi nanti.");
                        }
                        isLoading.value = false;
                      },
                      child: Text("Kirim Ulang"))
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "Pengguna tidak ditemukan.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password salah.");
        }
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password harus diisi.");
    }
  }
}
