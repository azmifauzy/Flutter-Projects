import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presenceapp/app/controllers/page_index_controller.dart';
import 'package:presenceapp/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomeView extends GetView<HomeController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final pageController = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jarvis Presence'),
          centerTitle: false,
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
                      children: [
                        ClipOval(
                          child: Container(
                            color: Colors.grey[200],
                            width: 75,
                            height: 75,
                            child: Image.network(
                              user["image"] != null
                                  ? user["image"]
                                  : "https://ui-avatars.com/api/?background=random&&name=${user["nama"].toLowerCase()}",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 250,
                              child: Text(
                                user["last_location"] != null
                                    ? "${user["last_location"]["address"]}"
                                    : "Belum Ada Lokasi.",
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${user["position"] != null ? user["position"] : "Belum Punya Posisi"}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${user["nip"]}",
                              style: TextStyle(
                                  letterSpacing: 3,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${user["nama"]}",
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.streamTodayPresence(),
                          builder: (context, snapshotToday) {
                            if (snapshotToday.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            Map<String, dynamic>? presence =
                                snapshotToday.data?.data();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("Masuk"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(presence?["masuk"] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(presence?["masuk"]["date"]))}"),
                                  ],
                                ),
                                Container(
                                  width: 2,
                                  color: Colors.white,
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    Text("Keluar"),
                                    Text(presence?["keluar"] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(presence?["keluar"]["date"]))}"),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 20),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[300],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Last 5 Days"),
                        TextButton(
                            onPressed: () {
                              pageController.changePage(4);
                            },
                            child: Text("See More"))
                      ],
                    ),
                    SizedBox(height: 20),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamLastFivePresences(),
                        builder: (context, snapshotPresences) {
                          if (snapshotPresences.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshotPresences.data?.docs.length == 0 ||
                              snapshotPresences.data == null) {
                            return Center(
                              child: Text("Belum Ada Data Presensi"),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshotPresences.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> presence =
                                  snapshotPresences.data!.docs[index].data();
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200],
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        Routes.DETAIL_PRESENSI,
                                        arguments: presence),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Masuk",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${DateFormat.yMMMEd().format(DateTime.parse(presence["date"]))}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                "${DateFormat.jms().format(DateTime.parse(presence["masuk"]["date"]))}"),
                                            SizedBox(height: 15),
                                            Text("Keluar",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(presence["keluar"] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(presence["keluar"]["date"]))}"),
                                          ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        })
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
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
