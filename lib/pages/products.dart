import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrcode/bloc/product/product_bloc.dart';
import 'package:qrcode/models/product.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/routes/router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read<ProductBloc>();
    return Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
        ),
        body: StreamBuilder<QuerySnapshot<Product>>(
          stream: productBloc.streamProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text("Tidak Ada Data."),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Tidak Dapat Mengambil Data!"),
              );
            }

            List<Product> allProducts = [];
            snapshot.data!.docs.forEach((element) {
              allProducts.add(element.data());
            });

            if (allProducts.isEmpty) {
              return Center(
                child: Text("Tidak Ada Data."),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                Product product = allProducts[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: () {
                      context.goNamed(Routes.PRODUCT_DETAIL,
                          params: {
                            "id": product.productId!,
                          },
                          extra: product);
                    },
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.code!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  product.name!,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Jumlah : ${product.qty!.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            child: QrImage(
                              data: product.code!,
                              size: 200,
                              version: QrVersions.auto,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
