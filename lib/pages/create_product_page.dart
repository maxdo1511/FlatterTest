import 'package:flutter/material.dart';

import '../model/product_card.dart';

class CreateProductPage extends StatefulWidget {

  const CreateProductPage({super.key, required this.onCreate});

  final Function(ProductCard) onCreate;

  @override
  State<CreateProductPage> createState() => CreateProductPageState();

}

class CreateProductPageState extends State<CreateProductPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _rarityController = TextEditingController();

  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заметку'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
              maxLines: 3,
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Категория'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
            ),
            TextField(
              controller: _rarityController,
              decoration: const InputDecoration(labelText: 'Редкость'),
            ),
            TextField(
              controller: _imageController, // Используем новый контроллер
              decoration: const InputDecoration(labelText: 'URL изображения или название файла'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final productCard = ProductCard(
                  id: _idController.text,
                  name: _titleController.text,
                  description: _descriptionController.text,
                  category: _categoryController.text,
                  price: _priceController.text,
                  rarity: _rarityController.text,
                );
                widget.onCreate(productCard);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}