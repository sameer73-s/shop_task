import 'package:flutter/material.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';

class ProductGridWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final ScrollController controller;

  const ProductGridWidget({
    super.key,
    required this.products,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      controller: controller,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Image
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                      image:
                          product.images != null && product.images!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(product.images!.first),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: product.images == null || product.images!.isEmpty
                        ? const Icon(Icons.image, color: Colors.grey)
                        : null,
                  ),
                ),

                const SizedBox(height: 8),

                /// Title
                Text(
                  product.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                /// Price
                Text(
                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                /// Rating
                Row(
                  children: List.generate(5, (i) {
                    return Icon(
                      Icons.star,
                      size: 16,
                      color: (product.rating ?? 0).toInt() > i
                          ? Colors.green
                          : Colors.grey.shade400,
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
