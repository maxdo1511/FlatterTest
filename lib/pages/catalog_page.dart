import 'package:flutter/material.dart';

import '../model/product_card.dart';
import '../model/rarity.dart';
import 'components/product_card_component.dart';
import 'create_product_page.dart';

class CatalogPage extends StatefulWidget {

  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => CatalogPageState();
}

class CatalogPageState extends State<CatalogPage> {

  Map<String, Rarity> rarities = {
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

  List<ProductCard> products = [
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

  List<String> filters = [];

  List<String> getCategories(List<ProductCard> products) {
    return products.map((product) => product.category).toSet().toList();
  }

  List<ProductCard> getFilteredProducts(List<ProductCard> products) {
    if (filters.isEmpty) {
      return products;
    }
    return products.where((product) => filters.contains(product.category)).toList();
  }

  String? addProduct(ProductCard productCard) {
    // validate

    // check empty
    if (productCard.id.isEmpty || productCard.name.isEmpty || productCard.price.isEmpty || productCard.category.isEmpty || productCard.rarity.isEmpty) {
      return "Заполните все поля";
    }

    // check id
    if (productCard.id.length != 3) {
      return "ID должен содержать 3 символа";
    }
    if (productCard.id.contains(RegExp(r'[^0-9]'))) {
      return "ID должен содержать только цифры";
    }
    if (products.map((product) => product.id).contains(productCard.id)) {
      return "Такой ID уже существует";
    }

    // check name
    if (productCard.name.length < 3) {
      return "Слишком короткое название";
    }
    if (products.map((product) => product.name.toLowerCase().replaceAll(" ", "")).contains(productCard.name.toLowerCase().replaceAll(" ", ""))) {
      return "Такое название уже существует";
    }

    // check price
    if (productCard.price.contains(RegExp(r'[^0-9]'))) {
      return "Цена должна содержать только цифры";
    }

    // check category
    if (productCard.category.length > 3) {
      return "Категория должна состоять из 3-х символов";
    }
    if (productCard.category.contains(RegExp(r'[a-zA-Z]'))) {
      return "Категория должна состоять только из латинских букв";
    }

    // check rarity
    if (!rarities.keys.contains(productCard.rarity)) {
      return "Такой редкости не существует";
    }

    // add
    setState(() {
      products.add(productCard);
    });
    return null;
  }

  void addFilter(String filter) {
    setState(() {
      filters.add(filter);
    });
  }

  void removeFilter(String filter) {
    setState(() {
      filters.remove(filter);
    });
  }

  void removeProduct(ProductCard productCard) {
    setState(() {
      products.remove(productCard);
    });
  }

  void addRarity(Rarity rarity) {
    setState(() {
      rarities[rarity.name] = rarity;
    });
  }

  void removeRarity(Rarity rarity) {
    setState(() {
      rarities.remove(rarity.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        alignment: Alignment.centerRight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: getCategories(products).length,
          itemBuilder: (BuildContext context, int index) {
            String category = getCategories(products)[index];
            return IconButton(
              icon: Text(category),
              style: IconButton.styleFrom(
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  ),
                  backgroundColor: filters.contains(category) ? Colors.grey : Colors.white
              ),
              onPressed: () {
                if (filters.contains(category)) {
                  removeFilter(category);
                } else {
                  addFilter(category);
                }
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        title: const Center(child: Text('Minecraft Shop'), ),
      ),
      body: ListView.builder(
          itemCount: getFilteredProducts(products).length,
          itemBuilder: (BuildContext context, int index) {
            ProductCard productCard = getFilteredProducts(products)[index];
            return ProductCardComponent(productCardModel: productCard, rarity: rarities[productCard.rarity]!);
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Открываем экран создания заметки
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProductPage (
                onCreate: (productCard) {
                  return addProduct(productCard);
                },
                products: products,
                rarities: rarities.keys.toList(),
              ),
            ),
          );
        },
        tooltip: 'Добавить товар',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}