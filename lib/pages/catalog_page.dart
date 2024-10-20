import 'package:flutter/material.dart';

import '../model/product_card.dart';
import '../model/rarity.dart';
import 'components/product_card_component.dart';
import 'create_product_page.dart';

class CatalogPage extends StatefulWidget {

  List<ProductCard> products;
  Map<String, Rarity> rarities;

  CatalogPage({super.key, required this.products, required this.rarities});

  @override
  State<CatalogPage> createState() => CatalogPageState();
}

class CatalogPageState extends State<CatalogPage> {

  List<String> filters = [];
  int cols = 1;

  void _setCols(int value) {
    if (cols == value) {
      return;
    }
    if (value < 1) {
      value = 1;
    }
    setState(() {
      cols = value;
    });
  }

  List<String> _getCategories(List<ProductCard> products) {
    return products.map((product) => product.category).toSet().toList();
  }

  List<ProductCard> _getFilteredProducts(List<ProductCard> products) {
    if (filters.isEmpty) {
      return products;
    }
    return products.where((product) => filters.contains(product.category)).toList();
  }

  void setFavorite(ProductCard productCard) {
    setState(() {
      productCard.isFavorite = !productCard.isFavorite;
    });
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
    if (widget.products.map((product) => product.id).contains(productCard.id)) {
      return "Такой ID уже существует";
    }

    // check name
    if (productCard.name.length < 3) {
      return "Слишком короткое название";
    }
    if (widget.products.map((product) => product.name.toLowerCase().replaceAll(" ", "")).contains(productCard.name.toLowerCase().replaceAll(" ", ""))) {
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
    if (!productCard.category.contains(RegExp(r'[a-zA-Z]'))) {
      return "Категория должна состоять только из латинских букв";
    }

    // check rarity
    if (!widget.rarities.keys.contains(productCard.rarity)) {
      return "Такой редкости не существует";
    }

    // add
    setState(() {
      widget.products.add(productCard);
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
      widget.products.remove(productCard);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Товар успешно удалён'),
        backgroundColor: Colors.green
    ));
  }

  void addRarity(Rarity rarity) {
    setState(() {
      widget.rarities[rarity.name] = rarity;
    });
  }

  void removeRarity(Rarity rarity) {
    setState(() {
      widget.rarities.remove(rarity.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        title: const Center(child: Text('Minecraft Shop'), ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.settings),
            onSelected: (value) {
              _setCols(value);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 1, child: Text('1 Column')),
                const PopupMenuItem(value: 2, child: Text('2 Columns')),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _getCategories(widget.products).length,
                itemBuilder: (BuildContext context, int index) {
                  String category = _getCategories(widget.products)[index];
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
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _getFilteredProducts(widget.products).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: cols == 1 ? 1.0 : 0.8,
              ),
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (BuildContext context, int index) {
                ProductCard productCard = _getFilteredProducts(widget.products)[index];
                return ProductCardComponent(
                    productCardModel: productCard,
                    size: MediaQuery.of(context).size.width / cols,
                    rarity: widget.rarities[productCard.rarity]!,
                    onRemove: (productCard) {
                      // Используем addPostFrameCallback для вызова removeProduct после завершения текущей сборки
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        removeProduct(productCard);
                      });
                    },
                    onSetFavorite: (productCard) {
                      setFavorite(productCard);
                    }
                );
              }
            ),
          ),
        ],
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
                products: widget.products,
                rarities: widget.rarities.keys.toList(),
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