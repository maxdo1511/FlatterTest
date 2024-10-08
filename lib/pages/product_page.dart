import 'package:flutter/material.dart';

import '../model/product_card.dart';
import '../model/rarity.dart';

class ProductPage extends StatelessWidget {

  final ProductCard productCardModel;
  final Rarity rarity;

  const ProductPage({super.key, required this.productCardModel, required this.rarity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(rarity.color),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        title: Text(productCardModel.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  productCardModel.name,
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  productCardModel.description,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image(image: AssetImage('assets/images/tile${productCardModel.id}.png'), width: 200, height: 200),
                ),
                const SizedBox(height: 20),
                Text(
                  "${productCardModel.price}\$",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ]
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Success ${productCardModel.name} added to cart', style: const TextStyle(fontSize: 24),),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Add to cart', style: TextStyle(fontSize: 30, color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}