import 'package:flutter/material.dart';

import 'model/product_card.dart';
import 'model/rarity.dart';
import 'pages/catalog_page.dart';
import 'pages/favorite_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  late Map<String, Rarity> rarities;
  late List<ProductCard> products;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();

    rarities = {
      "common": Rarity.fromJson({
        "name": "common",
        "color": "0xFFC8CDFF"
      }),
      "rare": Rarity.fromJson({
        "name": "rare",
        "color": "0xFF000EA1"
      }),
      "epic": Rarity.fromJson({
        "name": "epic",
        "color": "0xFFFF0069"
      }),
    };

    products = [
      ProductCard.fromJson({
        "id": "000",
        "name": "Leather Helmet",
        "description": "Leather helmet is a common helmet, only 1 armor point.",
        "price": "100",
        "category": "armor",
        "rarity": "common"
      }),
      ProductCard.fromJson({
        "id": "001",
        "name": "Chain Mail Helmet",
        "description": "Chain mail helmet is a common helmet, only 1.5 armor point.",
        "price": "150",
        "category": "armor",
        "rarity": "common"
      }),
      ProductCard.fromJson({
        "id": "002",
        "name": "Iron Helmet",
        "description": "Iron helmet is a rare helmet, 2 armor point.",
        "price": "300",
        "category": "armor",
        "rarity": "rare"
      }),
      ProductCard.fromJson({
        "id": "003",
        "name": "Diamond Helmet",
        "description": "Diamond helmet is a epic helmet, 3 armor point.",
        "price": "500",
        "category": "armor",
        "rarity": "epic"
      }),
      ProductCard.fromJson({
        "id": "004",
        "name": "Golden Helmet",
        "description": "Golden helmet is a rare helmet, 2 armor point, but it broke so fast!.",
        "price": "150",
        "category": "armor",
        "rarity": "rare"
      }),
      ProductCard.fromJson({
        "id": "010",
        "name": "Apple",
        "description": "Common food, 1 point of eat.",
        "price": "3",
        "category": "food",
        "rarity": "common"
      }),
      ProductCard.fromJson({
        "id": "011",
        "name": "Golden apple",
        "description": "Magic golden apple, regenerating health after eat.",
        "price": "20",
        "category": "food",
        "rarity": "rare"
      }),
      ProductCard.fromJson({
        "id": "064",
        "name": "Wooden sword",
        "description": "Start sword. 3 damage points.",
        "price": "100",
        "category": "weapon",
        "rarity": "common"
      }),
      ProductCard.fromJson({
        "id": "065",
        "name": "Stone sword",
        "description": "Start sword. 4 damage points.",
        "price": "120",
        "category": "weapon",
        "rarity": "common"
      }),
      ProductCard.fromJson({
        "id": "066",
        "name": "Iron sword",
        "description": "Good middle sword. 5 damage points.",
        "price": "300",
        "category": "weapon",
        "rarity": "rare"
      }),
      ProductCard.fromJson({
        "id": "067",
        "name": "Diamond sword",
        "description": "The best sword in the game. 7 damage points.",
        "price": "700",
        "category": "weapon",
        "rarity": "epic"
      }),
    ];

    _widgetOptions = <Widget>[
      CatalogPage(rarities: rarities, products: products),
      FavoritePage(rarities: rarities, products: products),
      ProfilePage(rarities: rarities, products: products),
    ];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minecraft Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        body:
        _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 20, 134, 225),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}