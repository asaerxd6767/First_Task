import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? sortBy; // in home I'll store the sortBy value and pass it to ProductCard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>( // I added a PopupMenuButton to the AppBar, sort with title - price - rating
            icon: const Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              setState(() {
                sortBy = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'title', child: Text('Title')),
              const PopupMenuItem(value: 'price', child: Text('Price')),
              const PopupMenuItem(value: 'rating', child: Text('Rating')),
            ],
          ),
        ],
      ),
      body: ProductCard(sortBy: sortBy), // pass the sortBy value to ProductCard
    );
  }
}
