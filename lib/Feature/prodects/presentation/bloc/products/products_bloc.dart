// ignore_for_file: type_literal_in_constant_pattern

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shop_task/Feature/prodects/domain/UseCases/get_product.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/core/errors/failure.dart';
import 'package:shop_task/core/strings/failures.dart';

import 'products_state.dart';

part 'products_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductUseCase getProductUseCase;
  int _page = 0;
  bool _isFetching = false;
  final List<ProductEntity> _allProducts = [];

  ProductsBloc({required this.getProductUseCase})
    : super(const ProductsInitial(islist: true)) {
    on<GetProductsEvent>(_onGetProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
    on<SwitchProductsEvent>(_onSwitchView);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  // ===================== Get Products =====================
  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingsState(islist: state.islist));
    _page = 0;
    _allProducts.clear();

    final result = await getProductUseCase.call(page: _page);

    result.fold(
      (failure) => emit(
        ProductsErrorState(
          message: _mapFailureToMessage(failure),
          islist: state.islist,
        ),
      ),
      (products) {
        _allProducts.addAll(products);
        emit(
          ProductsLoadedState(
            products: List.from(_allProducts),
            islist: state.islist ?? true,
          ),
        );
      },
    );
  }

  // ===================== Refresh Products =====================
  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingsState(islist: state.islist));
    _page = 0;
    _allProducts.clear();
    final result = await getProductUseCase.call(page: _page);

    result.fold(
      (failure) => emit(
        ProductsErrorState(
          message: _mapFailureToMessage(failure),
          islist: state.islist,
        ),
      ),
      (products) {
        _allProducts.addAll(products);
        emit(
          ProductsLoadedState(
            products: List.from(_allProducts),
            islist: state.islist ?? true,
          ),
        );
      },
    );
  }

  // ===================== Load More Products =====================
  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    if (_isFetching) return;

    _isFetching = true;
    _page++;

    final result = await getProductUseCase.call(page: _page);

    result.fold((_) {}, (products) {
      _allProducts.addAll(products);
      emit(
        ProductsLoadedState(
          products: List.from(_allProducts),
          islist: state.islist ?? true,
        ),
      );
    });

    _isFetching = false;
  }

  // ===================== Switch List / Grid =====================
  void _onSwitchView(SwitchProductsEvent event, Emitter<ProductsState> emit) {
    if (state is ProductsLoadedState) {
      final currentState = state as ProductsLoadedState;

      emit(currentState.copyWith(islist: !currentState.islist!));
    }
  }

  // ===================== Mapper =====================
  ProductsState _mapFailureOrProductsToState(
    Either<Failure, List<ProductEntity>> either,
    bool? islist,
  ) {
    return either.fold(
      (failure) => ProductsErrorState(
        message: _mapFailureToMessage(failure),
        islist: islist,
      ),
      (products) =>
          ProductsLoadedState(products: products, islist: islist ?? true),
    );
  }

  // ===================== Failure Messages =====================
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_Cache_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
