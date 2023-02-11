import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPresenceController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? start;
  DateTime end = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getPresences() async {
    String uid = await auth.currentUser!.uid;

    if (start == null) {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presences")
          .where("date", isLessThanOrEqualTo: end.toIso8601String())
          .orderBy("date", descending: true)
          .get();
    } else {
      return await firestore
          .collection("pegawai")
          .doc(uid)
          .collection("presences")
          .where("date", isGreaterThanOrEqualTo: start!.toIso8601String())
          .where("date", isLessThanOrEqualTo: end.toIso8601String())
          .orderBy("date", descending: true)
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
  }
}
