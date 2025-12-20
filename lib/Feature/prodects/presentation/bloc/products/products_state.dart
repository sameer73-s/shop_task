import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';

@immutable
sealed class ProductsState extends Equatable {
  final bool? islist; // keep nullable to match your bloc

  const ProductsState({this.islist = false});

  @override
  List<Object?> get props => [islist];
}

// Initial state
final class ProductsInitial extends ProductsState {
  const ProductsInitial({bool? islist = true}) : super(islist: islist);
}

// Loading state (match your bloc naming)
class ProductsLoadingsState extends ProductsState {
  const ProductsLoadingsState({bool? islist}) : super(islist: islist);
}

// Loaded state
class ProductsLoadedState extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoadedState({required this.products, bool? islist = true})
    : super(islist: islist);

  // copyWith for toggling list/grid view
  ProductsLoadedState copyWith({List<ProductEntity>? products, bool? islist}) {
    return ProductsLoadedState(
      products: products ?? this.products,
      islist: islist ?? this.islist,
    );
  }

  @override
  List<Object?> get props => [products, islist];
}

// Error state
class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState({required this.message, bool? islist})
    : super(islist: islist);

  @override
  List<Object?> get props => [message, islist];
}
