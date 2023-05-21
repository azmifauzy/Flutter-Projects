import 'package:flutter/material.dart';
import 'package:qrcode/routes/router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products Page"),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => context.goNamed(Routes.PRODUCT_DETAIL, params: {
                "id": "${index + 1}"
              }, queryParams: {
                "id": "${index + 1}",
                "title": "PRODUCT ${index + 1}",
                "deskripsi": "Deskripsi Product ${index + 1}"
              }),
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text("Product ke ${index + 1}"),
              subtitle: Text("Deskripsi Product ke ${index + 1}"),
            );
          },
        ));
  }
}
