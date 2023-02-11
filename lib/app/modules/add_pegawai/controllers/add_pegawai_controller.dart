import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nama = TextEditingController();
  TextEditingController nip = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController passwordAdmin = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesTambahPegawai() async {
    if (passwordAdmin.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passwordAdmin.text);

        final credential = await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: "password",
        );

        if (credential.user != null) {
          String uid = credential.user!.uid;
          firestore.collection("pegawai").doc(uid).set({
            "nip": nip.text,
            "nama": nama.text,
            "email": email.text,
            "role": "pegawai",
            "position": position.text,
            "uid": uid,
            "created_at": DateTime.now().toString()
          });
          // kirim email verifikasi
          await credential.user!.sendEmailVerification();
          Get.defaultDialog(
              title: "Pendaftaran Berhasil.",
              middleText: "Silahkan cek email kamu untuk verifikasi.",
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      // signout and relogin
                      await auth.signOut();
                      UserCredential userCredentialAdmin =
                          await auth.signInWithEmailAndPassword(
                              email: emailAdmin, password: passwordAdmin.text);

                      Get.back(); // tutup dialog pendaftaran berhasil
                      Get.back(); // tutup dialog validasi paswot admin
                      Get.back(); // back to home
                      Get.snackbar("Berhasil!", "Berhasil menambah pegawai.");
                    },
                    child: Text("Lanjutkan"))
              ]);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password terlalu singkat.");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Email telah digunakan.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password Admin Salah.");
        } else {
          Get.snackbar("Terjadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi beberapa saat.");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password tidak boleh kosong.");
    }
  }

  void tambah_pegawai() async {
    if (position.text.isNotEmpty &&
        nama.text.isNotEmpty &&
        nip.text.isNotEmpty &&
        email.text.isNotEmpty) {
      Get.defaultDialog(
          title: "Validasi Admin",
          content: Column(
            children: [
              Text("Masukan Password : "),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordAdmin,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              )
            ],
          ),
          actions: [
            OutlinedButton(onPressed: () => Get.back(), child: Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  await prosesTambahPegawai();
                },
                child: Text("Tambah Pegawai"))
          ]);
    } else {
      Get.snackbar("Terjadi Kesalahan", "Nama, NIP, dan Email harus diisi.");
    }
  }
}
