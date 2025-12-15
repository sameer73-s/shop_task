part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class getProductsEvent extends ProductsEvent {}

class refreshProductsEvent extends ProductsEvent {}
