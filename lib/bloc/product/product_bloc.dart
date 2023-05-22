import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:qrcode/models/product.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:qrcode/routes/router.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Product>> streamProducts() async* {
    yield* firestore
        .collection("products")
        .withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (product, _) => product.toJson())
        .snapshots();
  }

  ProductBloc() : super(ProductStateProductInitial()) {
    on<ProductEventScanProduct>((event, emit) async {
      // MENAMBAH PRODUK
      try {
        emit(ProductStateProductLoadingScan());
        var hasil =
            await firestore.collection("products").doc(event.code).get();

        emit(ProductStateProductCompleteScan(Product.fromJson(hasil.data()!)));
      } on FirebaseException catch (e) {
        emit(ProductStateProductError(e.message.toString()));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Menambah Produk"));
      }
    });
    on<ProductEventAddProduct>((event, emit) async {
      // MENAMBAH PRODUK
      try {
        emit(ProductStateProductLoading());

        var hasil = await firestore.collection("products").add({
          "name": event.name,
          "code": event.code,
          "qty": event.qty,
        });

        await firestore
            .collection("products")
            .doc(hasil.id)
            .update({"productId": hasil.id});

        emit(ProductStateProductCompleteAdd());
      } on FirebaseException catch (e) {
        emit(ProductStateProductError(e.message.toString()));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Menambah Produk"));
      }
    });
    on<ProductEventEditProduct>((event, emit) async {
      // MENGUBAH PRODUK
      try {
        emit(ProductStateProductLoading());

        await firestore
            .collection("products")
            .doc(event.productId)
            .update({"code": event.code, "name": event.name, "qty": event.qty});

        emit(ProductStateProductCompleteEdit());
      } on FirebaseException catch (e) {
        emit(ProductStateProductError(e.message.toString()));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Menambah Produk"));
      }
    });
    on<ProductEventDeleteProduct>((event, emit) async {
      // MENGHAPUS PRODUK
      try {
        emit(ProductStateProductLoading());
        await firestore.collection("products").doc(event.id).delete();
        emit(ProductStateProductCompleteDelete());
      } on FirebaseException catch (e) {
        emit(ProductStateProductError(e.message.toString()));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Menambah Produk"));
      }
    });
    on<ProductEventExportToPdf>((event, emit) async {
      // MENGEXPORT DATA PRODUK
      try {
        emit(ProductStateProductLoadingExport());

        var querySnap = await firestore
            .collection("products")
            .withConverter<Product>(
                fromFirestore: (snapshot, _) =>
                    Product.fromJson(snapshot.data()!),
                toFirestore: (product, _) => product.toJson())
            .get();

        List<Product> allProducts = [];
        for (var element in querySnap.docs) {
          Product product = element.data();
          allProducts.add(product);
        }

        final pdf = pw.Document();

        var data = await rootBundle.load("assets/fonts/Quicksand-Regular.ttf");
        var myFont = pw.Font.ttf(data);
        var myStyle = pw.TextStyle(font: myFont);

        pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            List<pw.TableRow> allData =
                List.generate(allProducts.length, (index) {
              return pw.TableRow(children: [
                pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text("${index + 1}",
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center)),
                pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text("${allProducts[index].code}",
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center)),
                pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text("${allProducts[index].name}",
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center)),
                pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text("${allProducts[index].qty}",
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center)),
                pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.BarcodeWidget(
                        color: PdfColors.black,
                        barcode: pw.Barcode.qrCode(),
                        data: "asdasdasd",
                        height: 35,
                        width: 35)),
              ]);
            });

            return [
              pw.Column(children: [
                pw.Center(
                    child: pw.Text("Catalog Products",
                        style: pw.TextStyle(font: myFont, fontSize: 24),
                        textAlign: pw.TextAlign.center)),
                pw.SizedBox(height: 20),
                pw.Table(
                    border:
                        pw.TableBorder.all(color: PdfColors.black, width: 2),
                    children: [
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text("No",
                                style: pw.TextStyle(
                                  font: myFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text("Product Code",
                                style: pw.TextStyle(
                                  font: myFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text("Product Name",
                                style: pw.TextStyle(
                                  font: myFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text("Quantity",
                                style: pw.TextStyle(
                                  font: myFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.center)),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text("QR Code",
                                style: pw.TextStyle(
                                  font: myFont,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.center)),
                      ]),

                      // SECOND ROW
                      ...allData,
                    ]),
              ])
            ];
          },
        ));

        // save pdf lalu buka pdfnya
        Uint8List bytes = await pdf.save();

        final dir = await getApplicationDocumentsDirectory();
        File file = File("${dir.path}/products.pdf");

        // masukin data bytes ke pdf
        await file.writeAsBytes(bytes);

        await OpenFile.open(file.path);
        print(file.path);

        emit(ProductStateProductCompleteExport());
      } on FirebaseException catch (e) {
        emit(ProductStateProductError("Tidak Dapat Mengunduh Data"));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Mengunduh Data"));
      }
    });
  }
}
