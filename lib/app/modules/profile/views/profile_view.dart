import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presenceapp/app/controllers/page_index_controller.dart';
import 'package:presenceapp/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final pageController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROFILE'),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> user = snapshot.data!.data()!;

                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              user["image"] != null
                                  ? user["image"]
                                  : "https://ui-avatars.com/api/?background=random&&name=${user["nama"].toLowerCase()}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "${user["nama"]}",
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text("${user["email"]}")),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        onTap: () =>
                            Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                        leading: Icon(Icons.person),
                        title: Text("Ubah Profile")),
                    ListTile(
                        onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD,
                            arguments: user),
                        leading: Icon(Icons.vpn_key),
                        title: Text("Ubah Password")),
                    if (user["role"] == "admin")
                      ListTile(
                          onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                          leading: Icon(Icons.person_add),
                          title: Text("Tambah Pegawai")),
                    ListTile(
                        onTap: () async {
                          if (controller.isLoading.isFalse) {
                            await FirebaseAuth.instance.signOut();
                            Get.offAllNamed(Routes.LOGIN);
                            controller.isLoading.value = true;
                          }
                        },
                        leading: Icon(Icons.logout),
                        title: Text("Logout")),
                  ],
                );
              } else {
                return Center(
                  child: Text("Tidak dapat memuat data."),
                );
              }
            }),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home, title: 'Beranda'),
            TabItem(icon: Icons.people, title: 'Profil'),
            TabItem(icon: Icons.fingerprint, title: 'Absen'),
            TabItem(icon: Icons.work_off, title: 'Cuti'),
            TabItem(icon: Icons.work_history, title: 'Riwayat'),
          ],
          initialActiveIndex: pageController.pageIndex.value,
          onTap: (int i) => pageController.changePage(i),
        ));
  }
}
