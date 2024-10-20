import 'package:flutter/material.dart';

import '../model/product_card.dart';

class CreateProductPage extends StatefulWidget {

  const CreateProductPage({super.key, required this.onCreate, required this.products, required this.rarities});

  final List<ProductCard> products;
  final List<String> rarities;

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
  // для обновления состояния контроллера
  var _text = '';

  @override
  void initState() {
    super.initState();
    _idController.addListener(_changeVlue);
    _titleController.addListener(_changeVlue);
    _descriptionController.addListener(_changeVlue);
    _categoryController.addListener(_changeVlue);
    _priceController.addListener(_changeVlue);
    _rarityController.addListener(_changeVlue);
  }
  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _rarityController.dispose();
    super.dispose();
  }

  void _changeVlue() {

  }

  String? get _errorId {
    final text = _idController.text;
    if (text.isEmpty) {
      return null;
    }
    if (text.length != 3) {
      return 'ID должен состоять из 3-х символов';
    }
    if (text.contains(RegExp(r'[^0-9]'))) {
      return 'ID должен состоять только из цифр';
    }
    if (widget.products.any((element) => element.id == text)) {
      return 'Такой ID уже существует';
    }
    return null;
  }

  String? get _errorTitle {
    final text = _titleController.text.toLowerCase();
    if (text.isEmpty) {
      return null;
    }
    if (text.length < 3) {
      return 'Слишком короткое название';
    }
    if (widget.products.any((element) => element.name.toLowerCase().replaceAll(" ", "") == text.replaceAll(" ", ""))) {
      return 'Такое название уже существует';
    }
    return null;
  }

  String? get _errorCategory {
    final text = _categoryController.text;
    if (text.isEmpty) {
      return null;
    }
    if (text.length < 3) {
      return 'Категория более трех символов';
    }
    if (!text.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Категория должна состоять только из латинских букв';
    }
    return null;
  }

  String? get _errorPrice {
    final text = _priceController.text;
    if (text.isEmpty) {
      return null;
    }
    if (text.contains(RegExp(r'[^0-9]'))) {
      return 'Цена должна состоять только из цифр';
    }
    return null;
  }

  String? get _errorRarity {
    final text = _rarityController.text;
    if (text.isEmpty) {
      return null;
    }
    if (widget.rarities.any((element) => element == text)) {
      return null;
    }
    return 'Такая редкость не существует';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _idController,
              onChanged: (text) => setState(() {
                () => _text;
              }),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'ID',
                  errorText: _errorId),
              ),
            TextField(
              controller: _titleController,
              onChanged: (text) => setState(() {
                    () => _text;
              }),
              decoration: InputDecoration(
                  labelText: 'Название',
                  errorText: _errorTitle
              ),
            ),
            TextField(
              controller: _descriptionController,
              onChanged: (text) => setState(() {
                    () => _text;
              }),
              decoration: const InputDecoration(labelText: 'Описание'),
              maxLines: 3,
            ),
            TextField(
              controller: _categoryController,
              onChanged: (text) => setState(() {
                    () => _text;
              }),
              decoration: InputDecoration(
                  labelText: 'Категория',
                  errorText: _errorCategory
              ),
            ),
            TextField(
              controller: _priceController,
              onChanged: (text) => setState(() {
                    () => _text;
              }),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Цена',
                  errorText: _errorPrice
              ),
            ),
            TextField(
              controller: _rarityController,
              onChanged: (text) => setState(() {
                    () => _text;
              }),
              decoration: InputDecoration(
                  labelText: 'Редкость',
                  errorText: _errorRarity
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final productCard = ProductCard(
                  id: _idController.text,
                  name: _titleController.text,
                  description: _descriptionController.text,
                  category: _categoryController.text,
                  price: _priceController.text,
                  rarity: _rarityController.text,
                  isFavorite: false,
                );
                var result = widget.onCreate(productCard);
                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result),
                      backgroundColor: Colors.red
                  ));
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Товар успешно добавлен'),
                      backgroundColor: Colors.green
                  ));
                }
              },
              child: const Text('Сохранить', style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}