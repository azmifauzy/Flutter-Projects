import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 20),
              width: 30,
              height: 30,
              child: Image.network(
                  fit: BoxFit.contain,
                  "https://github.com/kuldii/mytsel/blob/main/assets/icons/qr.png?raw=true"),
            ),
          )
        ],
        centerTitle: false,
        title: RichText(
            text: TextSpan(
                text: "Hai, ",
                style: TextStyle(fontSize: 18),
                children: [
              TextSpan(
                  text: "Muhammad Azmi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ])),
        backgroundColor: Color(0xFFEC2028),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: ClipPathClass(),
            child: Container(
              height: 250,
              width: Get.width,
              color: Color(0xFFEC2028),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: ClipInfoClass(),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        // height: 300,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xFFE52D27),
                          Color(0xFFB31217)
                        ])),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "081212310028",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.network(
                                      "https://github.com/kuldii/mytsel/blob/main/assets/logo/simpati.png?raw=true")
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Sisa Pulsa Anda",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rp34.000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Isi Pulsa",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFF7B731)),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(
                                      text: "Berlaku sampai ",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                      children: [
                                    TextSpan(
                                      text: "19 April 2023",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ])),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Telkomsel POIN",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF7B731),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Text("172",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                            ]),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatusCard(
                              title: "Internet", data: "12.19", satuan: " GB"),
                          StatusCard(
                              title: "Telpon", data: "0", satuan: " Min"),
                          StatusCard(title: "SMS", data: "23", satuan: " SMS")
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                Container(
                  height: 7,
                  color: Colors.grey[300],
                ),
                Expanded(
                    child: Container(
                  // color: Colors.purple,
                  child: Column(
                    children: [
                      // body
                      Expanded(
                          child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Kategori Paket",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemCategory(
                                  title: "Internet",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/internet.png?raw=true"),
                              ItemCategory(
                                  title: "Telpon",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/telpon.png?raw=true"),
                              ItemCategory(
                                  title: "SMS",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/sms.png?raw=true"),
                              ItemCategory(
                                  title: "Roaming",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/roaming.png?raw=true"),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemCategory(
                                  title: "Hiburan",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/hiburan.png?raw=true"),
                              ItemCategory(
                                  title: "Unggulan",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/unggulan.png?raw=true"),
                              ItemCategory(
                                  title: "Tersimpan",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/tersimpan.png?raw=true"),
                              ItemCategory(
                                  title: "Riwayat",
                                  icon:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/icons/riwayat-icon.png?raw=true"),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Terbaru dari Telkomsel",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Lihat Semua",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ItemTerbaru(
                                  image:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/images/images-1.png?raw=true",
                                ),
                                ItemTerbaru(
                                  image:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/images/images-2.png?raw=true",
                                ),
                                ItemTerbaru(
                                  image:
                                      "https://github.com/kuldii/mytsel/blob/main/assets/images/images-1.png?raw=true",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Tanggap COVID-19",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              CardTanggap(
                                title:
                                    "Diskon Spesial 25% Untuk Pelanggan Baru",
                                image: "assets/images/images-1.png",
                              ),
                              CardTanggap(
                                title: "Bebas Kuota Akses Layanan Kesehatan",
                                image: "assets/images/images-2.png",
                              ),
                              CardTanggap(
                                title:
                                    "Diskon Spesial 25% Untuk Pelanggan Baru",
                                image: "assets/images/images-1.png",
                              ),
                              CardTanggap(
                                title: "Bebas Kuota Akses Layanan Kesehatan",
                                image: "assets/images/images-2.png",
                              ),
                            ]),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "AYO! Pake LinkAja!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Pakai LinkAja untuk beli pulsa, beli paket data dan bayar tagihan lebih mudah.",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              CardAyo(
                                  title: "Bayar Serba Cepat",
                                  image: "assets/images/images-3.png"),
                              CardAyo(
                                  title: "Cukup Snap QR",
                                  image: "assets/images/images-4.png"),
                              CardAyo(
                                  title: "NO! Credit Card",
                                  image: "assets/images/images-5.png")
                            ]),
                          )
                        ],
                      )),
                      // navigasi
                      Card(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: context.mediaQueryPadding.bottom),
                          height: 80,
                          decoration: BoxDecoration(
                              border:
                                  Border(top: BorderSide(color: Colors.grey))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ItemNav(
                                  icon: "beranda",
                                  status: true,
                                  title: "Beranda",
                                ),
                                ItemNav(
                                  icon: "riwayat",
                                  status: false,
                                  title: "Riwayat",
                                ),
                                ItemNav(
                                  icon: "bantuan",
                                  status: false,
                                  title: "Bantuan",
                                ),
                                ItemNav(
                                  icon: "inbox",
                                  status: false,
                                  title: "Inbox",
                                ),
                                ItemNav(
                                  icon: "profile",
                                  status: false,
                                  title: "Akun Saya",
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardAyo extends StatelessWidget {
  const CardAyo({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      child: Container(
        width: 140,
        child: Column(
          children: [
            Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
              width: Get.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                title,
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardTanggap extends StatelessWidget {
  const CardTanggap({super.key, required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      child: Container(
        width: Get.width * 0.7,
        child: Column(
          children: [
            Image(
                width: Get.width,
                height: 130,
                fit: BoxFit.cover,
                image: AssetImage(image)),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTerbaru extends StatelessWidget {
  const ItemTerbaru({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: Get.width * 0.7,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
    );
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({super.key, required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          child: Image.network(fit: BoxFit.cover, icon),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class ItemNav extends StatelessWidget {
  const ItemNav(
      {super.key,
      required this.status,
      required this.title,
      required this.icon});

  final bool status;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 25,
          child: Image.asset(
              fit: BoxFit.contain,
              (status == true)
                  ? "assets/icons/$icon-active.png"
                  : "assets/icons/$icon.png"),
        ),
        SizedBox(height: 5),
        Text(title,
            style: TextStyle(
                fontSize: 12,
                color:
                    (status == true) ? Color(0xFFEC202B) : Color(0xFF747D80)))
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    required this.title,
    required this.data,
    required this.satuan,
  });

  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Get.width * 0.25,
        // color: Colors.amber,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          RichText(
              text: TextSpan(
                  text: data,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEC202B)),
                  children: [
                TextSpan(
                    text: satuan,
                    style: TextStyle(fontSize: 16, color: Color(0xFF747D80)))
              ]))
        ]),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 80, size.height);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
