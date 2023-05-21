import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranify/app/data/models/surah.dart';
import 'package:quranify/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quranify',
            style: TextStyle(
                fontSize: 24,
                fontFamily: "sans-serif",
                fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Surah>>(
          future: controller.getAllSurah(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text("Tidak ada Data"),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Surah surah = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                    },
                    leading: CircleAvatar(
                      child: Text("${surah.number}"),
                    ),
                    title: Text(
                        "${surah.name?.transliteration?.en} (${surah.numberOfVerses})"),
                    subtitle: Text(
                        "${surah.name?.translation?.en} - ${surah.revelation?.en}"),
                    trailing: Text("${surah.name?.short}"),
                  );
                });
          }),
    );
  }
}
