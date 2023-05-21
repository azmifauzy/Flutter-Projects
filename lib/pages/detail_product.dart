import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage(this.id, this.data, {super.key});

  final String id;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DetailProduct Page"),
      ),
      body: Center(
        child: Text("DetailProduct Page ${id}"),
      ),
    );
  }
}
