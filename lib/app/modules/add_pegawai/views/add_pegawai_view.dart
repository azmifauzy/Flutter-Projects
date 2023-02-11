import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH PEGAWAI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.nip,
            decoration: InputDecoration(
                labelText: "NIP : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nama,
            decoration: InputDecoration(
                labelText: "Nama : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.email,
            decoration: InputDecoration(
                labelText: "Email : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.position,
            decoration: InputDecoration(
                labelText: "Position : ", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                controller.tambah_pegawai();
              },
              child: Text("Tambah Pegawai"))
        ],
      ),
    );
  }
}
