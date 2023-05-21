import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateProductInitial()) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

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

        emit(ProductStateProductComplete());
      } on FirebaseException catch (e) {
        emit(ProductStateProductError(e.message.toString()));
      } catch (e) {
        emit(ProductStateProductError("Tidak Dapat Menambah Produk"));
      }
    });
    on<ProductEventEditProduct>((event, emit) {
      // MENGUBAH PRODUK
    });
    on<ProductEventDeleteProduct>((event, emit) {
      // MENGHAPUS PRODUK
    });
  }
}
