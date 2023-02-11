import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic> presence = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presence Detail'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  "${DateFormat.yMMMEd().format(DateTime.parse(presence["date"]))}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Masuk", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${DateFormat.jms().format(DateTime.parse(presence["masuk"]["date"]))}"),
              SizedBox(
                height: 5,
              ),
              Text("${presence["masuk"]["address"]}"),
              SizedBox(
                height: 5,
              ),
              Text("${presence["masuk"]["status"]}"),
              SizedBox(height: 15),
              Text("Keluar", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text(presence["keluar"] == null
                  ? "-"
                  : "${DateFormat.jms().format(DateTime.parse(presence["keluar"]["date"]))}"),
              SizedBox(
                height: 5,
              ),
              Text(presence["keluar"] == null
                  ? "-"
                  : "${presence["keluar"]["address"]}"),
              SizedBox(
                height: 5,
              ),
              Text(presence["keluar"] == null
                  ? "-"
                  : "${presence["keluar"]["status"]}"),
            ]),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200]),
          )
        ],
      ),
    );
  }
}
