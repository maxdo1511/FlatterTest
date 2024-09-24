import 'package:flutter/material.dart';

import '../../model/product_card.dart';
import '../../model/rarity.dart';
import '../product_page.dart';

class ProductCardComponent extends StatelessWidget {

  const ProductCardComponent({super.key, required this.productCardModel, required this.rarity});

  final ProductCard productCardModel;
  final Rarity rarity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productCardModel: productCardModel, rarity: rarity),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Color(rarity.color),
              width: 4.0,
            ),
          ),
          width: double.infinity,
          constraints: const BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    productCardModel.name,
                    style: const TextStyle(fontSize: 34, color: Colors.black),
                  ),
                ),
                Text(
                  productCardModel.description,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
                Image(image: AssetImage('assets/images/tile${productCardModel.id}.png'), width: 200, height: 200),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text(
                      "${productCardModel.price}\$",
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}