import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_card.dart';
import '../model/rarity.dart';

class ProfilePage extends StatefulWidget {
  List<ProductCard> products;
  Map<String, Rarity> rarities;

  ProfilePage({super.key, required this.products, required this.rarities});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Container(
        child: const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Максим', style: TextStyle(fontSize: 24),),
                    Text('Дорошко', style: TextStyle(fontSize: 24),),
                    Text('Kisapa', style: TextStyle(fontSize: 24),),
                    Text('maxdo1579@mail.ru', style: TextStyle(fontSize: 24),),
                ]
                ),
                Text("Крым наш (Русский)")
              ],
            ),
          ),
        )
      ),
    );
  }

}