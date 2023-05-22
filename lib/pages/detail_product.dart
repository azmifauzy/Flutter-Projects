import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/bloc/bloc.dart';
import 'package:qrcode/config/colors.dart';
import 'package:qrcode/models/product.dart';
import 'package:qrcode/routes/router.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage(this.id, this.product, {super.key});

  final String id;
  final Product product;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code!;
    nameC.text = product.name!;
    qtyC.text = product.qty!.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("DetailProduct Page"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: product.code!,
                  size: 200,
                  version: QrVersions.auto,
                ),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.text,
            readOnly: true,
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
            controller: nameC,
            keyboardType: TextInputType.text,
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
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Product Quantity",
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.primaryColor),
              onPressed: () {
                context.read<ProductBloc>().add(ProductEventEditProduct(
                    productId: product.productId.toString(),
                    code: codeC.text,
                    name: nameC.text,
                    qty: int.tryParse(qtyC.text) ?? 0));
              },
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateProductError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.msg)));
                  }
                  if (state is ProductStateProductCompleteEdit) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: AppColors.primaryColor,
                      content: Text("Berhasil Mengubah Produk"),
                      duration: Duration(seconds: 2),
                    ));
                    context.pop();
                  }
                },
                builder: (context, state) {
                  return const Text("Save Product",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500));
                },
              )),
          SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                context
                    .read<ProductBloc>()
                    .add(ProductEventDeleteProduct(product.productId!));
              },
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateProductError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.msg)));
                  }
                  if (state is ProductStateProductCompleteDelete) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColors.primaryColor,
                      content: Text("Berhasil Menghapus Produk"),
                      duration: Duration(seconds: 2),
                    ));
                    context.pop();
                  }
                },
                builder: (context, state) {
                  return Text("Delete Product",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red));
                },
              ))
        ],
      ),
    );
  }
}
