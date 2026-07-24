import '../data/api_service.dart';
import '../data/product_model.dart';
import 'package:flutter/material.dart';
import 'product_info.dart';

class ProductCard extends StatefulWidget {
  final String? sortBy;

  const ProductCard({super.key, required this.sortBy});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<Product> products = [];
  bool isLoading = true; // helped me alot (Also best practice with data to load), knowing if my screen really lagged or data isn't dataing...

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // Fetch products from the API and update the state
  // understood the future<List<dynamic>> 
  // and how to use it to fetch data from the API,
  // then convert it to a list of Product objects using the fromJson factory constructor.
  void loadProducts() async {
    var data = await FetchData.getProducts();
    setState(() {
      // Why I used map? ngl the first approach I wanted to use is for loop, but then realised I can handle this future list with map.
      products = data
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
      isLoading = false;
    });
  }

  // Sorting the products using the sortBy value
  List<Product> getSortedProducts(List<Product> items) {
    final sorted = List<Product>.from(items);

    switch (widget.sortBy) {
      case 'price':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'title':
      default:
        sorted.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
    }

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final sortedProducts = getSortedProducts(products);

    // ngl, I didn't know how to display the data other than using a listview.builder...
    // searched about gridview but didn't work for me, ehhh...
    return ListView.builder(
      itemCount: sortedProducts.length,
      itemBuilder: (context, index) {
        final product = sortedProducts[index];
        return Card(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Image.network(product.thumbnail, fit: BoxFit.cover),
              ProductInfo(product: product), // Why I made this? so I can make it look like a listTile, and dont get confused later.

            ],
          ),
        );
      },
    );
  }
}
