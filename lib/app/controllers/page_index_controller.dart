import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presenceapp/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        pageIndex.value = 0;
        break;
      case 1:
        Get.offAllNamed(Routes.PROFILE);
        pageIndex.value = 1;
        break;
      case 2:
        Map<String, dynamic> geoResponse = await determinePosition();
        if (geoResponse["error"] != true) {
          Position position = geoResponse["position"];

          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placemarks[0].street} ${placemarks[0].postalCode}, ${placemarks[0].country}";
          await updatePosition(position, address);

          // CEK JARAK DARI KANTOR (SESUAIKAN KANTOR)
          // JARAK EMULATOR lat 37.421998333333335 long -122.084
          // JARAK RUMAH ANE lat -6.212518 long 107.039563
          double distance = await Geolocator.distanceBetween(37.421998333333335,
              -122.084, position.latitude, position.longitude);

          await presensi(position, address, distance);
        } else {
          Get.snackbar("Terjadi Kesalahan", geoResponse["message"]);
        }
        break;
      case 3:
        print("Cuti");
        break;
      case 4:
        Get.offAllNamed(Routes.HISTORY_PRESENCE);
        pageIndex.value = 4;
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presensi(
      Position position, String address, double distance) async {
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> colPresences =
        await firestore.collection("pegawai").doc(uid).collection("presences");

    QuerySnapshot<Map<String, dynamic>> snapPresence = await colPresences.get();

    DateTime today = DateTime.now();
    String todayDocId = DateFormat.yMd().format(today).replaceAll("/", "-");

    String status = "Out of Site";
    if (distance <= 200) {
      status = "On Site";
    }

    if (snapPresence.docs.length == 0) {
      // BELUM PERNAH ABSEN & SET ABSEN MASUK
      colPresences.doc(todayDocId).set({
        "date": today.toIso8601String(),
        "masuk": {
          "date": today.toIso8601String(),
          "lat": position.latitude,
          "long": position.longitude,
          "address": address,
          "status": status,
          "distance": distance
        }
      });
      Get.snackbar("Berhasil Absen Masuk", address);
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await colPresences.doc(todayDocId).get();

      if (todayDoc.exists == true) {
        // CEK APAKAH ABSEN KELUARNYA ADA
        Map<String, dynamic>? todayPresence = todayDoc.data();
        if (todayPresence?["keluar"] != null) {
          Get.snackbar("Kamu Sudah Absen Hari Ini", address);
        } else {
          // tinggal absen keluar
          // SUDAH ABSEN HARI INI & SET ABSEN KELUAR
          colPresences.doc(todayDocId).update({
            "keluar": {
              "date": today.toIso8601String(),
              "lat": position.latitude,
              "long": position.longitude,
              "address": address,
              "status": status,
              "distance": distance
            }
          });
          Get.snackbar("Berhasil Absen Keluar", address);
        }
      } else {
        // absen masuk
        colPresences.doc(todayDocId).set({
          "date": today.toIso8601String(),
          "masuk": {
            "date": today.toIso8601String(),
            "lat": position.latitude,
            "long": position.longitude,
            "address": address,
            "status": status,
            "distance": distance
          }
        });
        Get.snackbar("Berhasil Absen Masuk", address);
      }
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = await auth.currentUser!.uid;
    await firestore.collection("pegawai").doc(uid).update({
      "last_location": {
        "lat": position.latitude,
        "long": position.longitude,
        "address": address
      }
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message": "Silahkan izinkan akses GPS untuk mendapatkan lokasi",
          "error": true
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message": "Silahkan izinkan akses GPS untuk mendapatkan lokasi",
        "error": true
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {
      "position": position,
      "message": "Berhasil mendapat posisi device",
      "error": false
    };
  }
}
