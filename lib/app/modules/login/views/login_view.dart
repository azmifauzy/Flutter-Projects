import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mytsel/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

import 'package:flutter/src/material/colors.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: ListView(
          children: [
            Container(
              height: 150,
              alignment: Alignment.centerLeft,
              child: Image.network(
                  fit: BoxFit.contain,
                  "https://github.com/kuldii/mytsel/blob/main/assets/logo/logo-login.png?raw=true"),
            ),
            SizedBox(height: 30),
            Text(
              "Silahkan masuk dengan nomor telkomsel kamu",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "Nomor HP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.phone_controller,
              keyboardType: TextInputType.phone,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Cth. 0812123xxxx"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Obx(() => Checkbox(
                      activeColor: Colors.red,
                      value: controller.checkC.value,
                      onChanged: (value) => controller.checkC.toggle(),
                    )),
                Expanded(
                    child: RichText(
                        text: TextSpan(
                            children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("KLIK SYARAT");
                          },
                        text: "syarat, ",
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("KLIK KETENTUAN");
                          },
                        text: "ketentuan, ",
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        text: "dan ",
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("KLIK PRIVASI");
                          },
                        text: "privasi ",
                        style: TextStyle(color: Colors.red),
                      ),
                      TextSpan(
                        text: "Telkomsel",
                      )
                    ],
                            style: TextStyle(color: Colors.black),
                            text: "Saya menyutujui ")))
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text(
                "MASUK",
                style: TextStyle(color: Color(0xFF747080)),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300], fixedSize: Size(150, 50)),
            ),
            SizedBox(height: 20),
            Center(
              child: Text("Atau masuk menggunakan"),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://github.com/kuldii/mytsel/blob/main/assets/icons/fb.png?raw=true"),
                      SizedBox(width: 7),
                      Text(
                        "Facebook",
                        style:
                            TextStyle(color: Color(0xFF747080), fontSize: 16),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(150, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFF3B5998)))),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://github.com/kuldii/mytsel/blob/main/assets/icons/twitter.png?raw=true"),
                      SizedBox(width: 7),
                      Text(
                        "Facebook",
                        style:
                            TextStyle(color: Color(0xFF747080), fontSize: 16),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(150, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFF3B5998)))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
