import 'package:flutter/material.dart';

import '../../model/product_card.dart';
import '../../model/rarity.dart';
import '../product_page.dart';

class ProductCardComponent extends StatefulWidget {

  final ProductCard productCardModel;
  final Rarity rarity;
  final Function(ProductCard) onRemove;

  const ProductCardComponent({super.key, required this.productCardModel, required this.rarity, required this.onRemove});

  @override
  State<ProductCardComponent> createState() => ProductCardComponentState();

}

class ProductCardComponentState extends State<ProductCardComponent> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productCardModel: widget.productCardModel, rarity: widget.rarity),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Color(widget.rarity.color),
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
                    widget.productCardModel.name,
                    style: const TextStyle(fontSize: 34, color: Colors.black),
                  ),
                ),
                Text(
                  widget.productCardModel.description,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
                Image(image: AssetImage('assets/images/tile${widget.productCardModel.id}.png'), width: 200, height: 200),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text(
                      "${widget.productCardModel.price}\$",
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {
                  widget.onRemove(widget.productCardModel);
                },
                  child: const Text('Удалить', style: TextStyle(fontSize: 20, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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

  @override
  void initState() {
    super.initState();
  }
}