part of 'product_bloc.dart';

abstract class ProductState {}

class ProductStateProductInitial extends ProductState {}

class ProductStateProductLoading extends ProductState {}

class ProductStateProductComplete extends ProductState {}

class ProductStateProductError extends ProductState {
  ProductStateProductError(this.msg);
  final String msg;
}
