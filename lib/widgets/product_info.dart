import 'package:flutter/material.dart';
import '../data/product_model.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 25),
                  Text(
                    '${product.rating}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(product.description),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${(product.price - ((product.price * product.discountPercentage) / 100)).toStringAsFixed(2)} EGP',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Text(
              '${product.price} EGP',
              style: TextStyle(color: Colors.grey, decoration: .lineThrough),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Return Policy: ${product.returnPolicy}'),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: product.stock > 10
                  ? Text('Stock: ${product.stock}')
                  : Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red,),
                        Text(
                          'Only ${product.stock} left',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
