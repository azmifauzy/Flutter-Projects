import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presenceapp/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  void ubahPassword() async {
    if (password.text.isNotEmpty) {
      if (password.text != "password") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(password.text);
          Get.defaultDialog(
              title: "Berhasil Ubah Password",
              middleText: "Password Berhasil Diubah.",
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      await auth.signOut();
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Text("Keluar")),
                ElevatedButton(
                    onPressed: () async {
                      await auth.signOut();
                      await auth.signInWithEmailAndPassword(
                          email: email, password: password.text);
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: Text("Lanjutkan"))
              ]);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat.");
          } else if (e.code == 'email-already-in-use') {
            Get.snackbar("Terjadi Kesalahan", "Email telah digunakan.");
          }
        } catch (e) {
          Get.snackbar(
              "Terjadi Kesalahan", "Silahkan coba lagi beberapa saat.");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Silahkan cari password yang lain.");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password Baru Wajib diisi");
    }
  }
}
