import 'dart:ffi';

class ProductCard {

  late String id;
  late String name;
  late String description;
  late String price;
  late String category;
  late String rarity;
  late bool isFavorite;

  ProductCard({required this.id, required this.name, required this.description, required this.price, required this.category, required this.rarity, required this.isFavorite});

  factory ProductCard.fromJson(Map<String, dynamic> json) {
    return ProductCard(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      rarity: json['rarity'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

}