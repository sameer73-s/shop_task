part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductsEvent {}

class RefreshProductsEvent extends ProductsEvent {}

class SwitchProductsEvent extends ProductsEvent {}

class LoadMoreProductsEvent extends ProductsEvent {}
