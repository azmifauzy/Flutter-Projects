import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranify/app/data/models/surah.dart';
import 'package:quranify/app/data/models/surah_detail.dart' as detail;

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "SURAH ${surah.name?.transliteration?.en?.toUpperCase() ?? 'ERROR'}"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name?.transliteration?.en?.toUpperCase() ?? 'ERROR'}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "(${surah.name?.translation?.en?.toUpperCase() ?? 'ERROR'})",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${surah.numberOfVerses} Ayah | ${surah.revelation?.en}",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder<detail.SurahDetail>(
                future: controller.getDetailSurah(surah.number.toString()),
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
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.verses?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (snapshot.data?.verses == null ||
                              snapshot.data?.verses?.length == 0) {
                            return Center(child: SizedBox());
                          }
                          detail.Verse? ayat = snapshot.data?.verses?[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        child: Text("${index + 1}"),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.bookmark_add_outlined)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.play_arrow))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${ayat!.text?.arab}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${ayat!.text?.transliteration.en}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${ayat!.translation?.en}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        }),
                  );
                })
          ],
        ));
  }
}
