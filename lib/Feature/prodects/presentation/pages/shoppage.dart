import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_task/Feature/prodects/presentation/bloc/products/products_bloc.dart';
import 'package:shop_task/Feature/prodects/presentation/bloc/products/products_state.dart';
import 'package:shop_task/Feature/prodects/presentation/widgets/product_list_widget.dart';
import 'package:shop_task/Feature/prodects/presentation/widgets/product_grid_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<ProductsBloc>().add(LoadMoreProductsEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoadedState) {
                return IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    context.read<ProductsBloc>().add(SwitchProductsEvent());
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductsBloc>().add(RefreshProductsEvent());
                },
                child: state.islist!
                    ? ProductListWidget(
                        products: state.products,
                        controller: _scrollController,
                      )
                    : ProductGridWidget(
                        products: state.products,
                        controller: _scrollController,
                      ),
              );
            } else if (state is ProductsErrorState) {
              return ListView(children: [Center(child: Text(state.message))]);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
