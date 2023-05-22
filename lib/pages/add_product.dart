import 'package:flutter/material.dart';
import 'package:qrcode/bloc/bloc.dart';
import 'package:qrcode/config/colors.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final TextEditingController codeC = TextEditingController();
  final TextEditingController namaC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Products"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: codeC,
              keyboardType: TextInputType.text,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: "Product Code",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: namaC,
              decoration: InputDecoration(
                labelText: "Product Name",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              controller: qtyC,
              decoration: InputDecoration(
                labelText: "Product Quantity",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: AppColors.primaryColor),
                onPressed: () {
                  context.read<ProductBloc>().add(ProductEventAddProduct(
                      code: codeC.text,
                      name: namaC.text,
                      qty: int.tryParse(qtyC.text) ?? 0));
                },
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is ProductStateProductError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.msg)));
                    }
                    if (state is ProductStateProductCompleteAdd) {
                      codeC.clear();
                      namaC.clear();
                      qtyC.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: AppColors.primaryColor,
                        content: Text("Berhasil Menambah Produk"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      state is ProductStateProductLoading
                          ? "Loading..."
                          : "Save Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    );
                  },
                ))
          ],
        ));
  }
}
