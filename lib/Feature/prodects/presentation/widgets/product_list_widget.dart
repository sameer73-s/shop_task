import 'package:flutter/material.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';

class ProductListWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final ScrollController controller;

  const ProductListWidget({
    super.key,
    required this.products,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      controller: controller,
      itemCount: products.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final product = products[index];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
                image: product.images != null && product.images!.isNotEmpty
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

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    product.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.shippingInformation ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          size: 18,
                          color: (product.rating ?? 0).toInt() > i
                              ? Colors.green
                              : Colors.grey.shade400,
                        );
                      }),
                      const SizedBox(width: 6),
                      Text(
                        '${product.reviews?.length ?? 0} Reviews',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
