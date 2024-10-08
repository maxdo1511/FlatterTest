import 'package:flutter/material.dart';

import '../../model/product_card.dart';
import '../../model/rarity.dart';
import '../product_page.dart';

class ProductCardComponent extends StatefulWidget {

  final ProductCard productCardModel;
  final Rarity rarity;
  final double size;
  final Function(ProductCard) onRemove;
  final Function(ProductCard) onSetFavorite;

  const ProductCardComponent({super.key, required this.productCardModel, required this.rarity, required this.onRemove, required this.size, required this.onSetFavorite});

  @override
  State<ProductCardComponent> createState() => ProductCardComponentState();

}

class ProductCardComponentState extends State<ProductCardComponent> {

  @override
  Widget build(BuildContext context) {

    int size = widget.size.toInt();
    double titleSize = 12;
    if (size > 220) {
      titleSize = 24;
    }
    if (size > 300) {
      titleSize = 32;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(productCardModel: widget.productCardModel, rarity: widget.rarity),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Color(widget.rarity.color),
                width: 4.0,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          widget.productCardModel.name,
                          style: TextStyle(fontSize: titleSize, color: Colors.black),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          widget.productCardModel.description,
                          style: TextStyle(fontSize: titleSize / 2, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image(
                        image: AssetImage('assets/images/tile${widget.productCardModel.id}.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Text(
                        "${widget.productCardModel.price}\$",
                        style: TextStyle(fontSize: titleSize / 2, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(onPressed: () {
                      widget.onRemove(widget.productCardModel);
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(size / 3, size / 3 * 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Удалить', style: TextStyle(fontSize: titleSize/1.2, color: Colors.white),),
                    ),
                  ],
                )
              ],

            ),
          ),
          Positioned(
            top: 4.0, // Расположение кнопки по вертикали
            right: 4.0, // Расположение кнопки по горизонтали
            child: IconButton(
              icon: const Icon(Icons.favorite), // Иконка сердечка
              color: widget.productCardModel.isFavorite ? Colors.red : Colors.grey, // Цвет иконки
              onPressed: () {
                widget.onSetFavorite(widget.productCardModel);
              },
            ),
          ),
        ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}