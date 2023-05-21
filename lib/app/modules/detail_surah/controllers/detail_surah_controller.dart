import 'package:get/get.dart';
import 'package:quranify/app/data/models/surah_detail.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  Future<SurahDetail> getDetailSurah(String id) async {
    // DETAIL SURAH
    Uri urlSurah = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var resSurah = await http.get(urlSurah);
    Map<String, dynamic> dataSurah =
        (json.decode(resSurah.body) as Map<String, dynamic>)["data"];

    SurahDetail tes = SurahDetail.fromJson(dataSurah);

    print(urlSurah);
    print(resSurah);
    print(tes);

    return SurahDetail.fromJson(dataSurah);
  }
}
