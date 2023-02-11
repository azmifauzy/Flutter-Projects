import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presenceapp/app/controllers/page_index_controller.dart';
import 'package:presenceapp/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/history_presence_controller.dart';

class HistoryPresenceView extends GetView<HistoryPresenceController> {
  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Presence History'),
          centerTitle: true,
        ),
        body: GetBuilder<HistoryPresenceController>(builder: (c) {
          return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: controller.getPresences(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
                  return Center(
                    child: Text("Belum Ada Data Presensi"),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> presence =
                        snapshot.data!.docs[index].data();

                    return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.DETAIL_PRESENSI,
                              arguments: presence),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Masuk",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          "${DateFormat.yMMMEd().format(DateTime.parse(presence["date"]))}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                          fontWeight: FontWeight.bold)),
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
              });
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // syncfunction datepicker
            Get.dialog(Dialog(
              child: Container(
                height: 400,
                padding: EdgeInsets.all(20),
                child: SfDateRangePicker(
                    showActionButtons: true,
                    onCancel: () => Get.back(),
                    onSubmit: (obj) {
                      if (obj != null) {
                        // proses
                        if ((obj as PickerDateRange).endDate != null) {
                          controller.pickDate(obj.startDate!, obj.endDate!);
                          Get.back();
                        } else {
                          Get.snackbar("Tanggal Tidak Valid",
                              "Pilih Tanggal Akhir Terlebih Dahulu");
                        }
                      } else {
                        Get.snackbar("Tanggal Tidak Valid",
                            "Pilih Tanggal Terlebih Dahulu");
                      }
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    monthViewSettings:
                        DateRangePickerMonthViewSettings(firstDayOfWeek: 1)),
              ),
            ));
          },
          child: Icon(Icons.format_list_bulleted_rounded),
        ),
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
