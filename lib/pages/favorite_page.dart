import 'package:flutter/material.dart';

import '../model/product_card.dart';
import '../model/rarity.dart';

class FavoritePage extends StatefulWidget {

  List<ProductCard> products;
  Map<String, Rarity> rarities;

  FavoritePage({super.key, required this.products, required this.rarities});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  List<ProductCard> getFavorites() {
    // select favorites
    return widget.products.where((product) => product.isFavorite).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: getFavorites().length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(getFavorites()[index].name),
              subtitle: Text(getFavorites()[index].category),
            );
          },
        ),
      ),
    );
  }

}