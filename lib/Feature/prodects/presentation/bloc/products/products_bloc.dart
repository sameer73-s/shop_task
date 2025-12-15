// ignore_for_file: type_literal_in_constant_pattern

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shop_task/Feature/prodects/domain/UseCases/get_product.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/core/errors/failure.dart';
import 'package:shop_task/core/strings/failures.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductUseCase getProductUseCase;
  ProductsBloc({required this.getProductUseCase}) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is getProductsEvent) {
        emit(ProductsLoadingsState());
        final failurerorproduct = await getProductUseCase.call();
        emit(_mapFailureorproductstoState(failurerorproduct));
      } else if (event is refreshProductsEvent) {
        emit(ProductsLoadingsState());
        final failurerorproduct = await getProductUseCase.call();
        emit(_mapFailureorproductstoState(failurerorproduct));
      }
    });
  }

  ProductsState _mapFailureorproductstoState(
    Either<Failure, List<ProductEntity>> either,
  ) {
    return either.fold(
      (failure) => ProductsErrorState(message: _mapFailureToMessage(failure)),
      (products) => ProductsLoadedState(products: products),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_Cache_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
