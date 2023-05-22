part of 'product_bloc.dart';

abstract class ProductState {}

class ProductStateProductInitial extends ProductState {}

class ProductStateProductLoading extends ProductState {}

class ProductStateProductCompleteDelete extends ProductState {}

class ProductStateProductCompleteEdit extends ProductState {}

class ProductStateProductCompleteAdd extends ProductState {}

class ProductStateProductError extends ProductState {
  ProductStateProductError(this.msg);
  final String msg;
}

class ProductStateProductLoadingExport extends ProductState {}

class ProductStateProductCompleteExport extends ProductState {}

class ProductStateProductLoadingScan extends ProductState {}

class ProductStateProductCompleteScan extends ProductState {
  ProductStateProductCompleteScan(this.product);
  Product product;
}
