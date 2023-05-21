import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quranify/app/data/models/surah.dart';
import 'package:quranify/app/data/models/surah_detail.dart';

void main() async {
  // ALL SURAH
  Uri url = Uri.parse("https://api.quran.gading.dev/surah/");
  var res = await http.get(url);
  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  Surah surah = Surah.fromJson(data[113]);

  // DETAIL SURAH
  Uri urlSurah =
      Uri.parse("https://api.quran.gading.dev/surah/${surah.number}");
  var resSurah = await http.get(urlSurah);
  Map<String, dynamic> dataSurah =
      (json.decode(resSurah.body) as Map<String, dynamic>)["data"];

  SurahDetail surahDetail = SurahDetail.fromJson(dataSurah);
}
