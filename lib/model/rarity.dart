import 'package:flutter/material.dart';

class Rarity {

  final String name;
  final int color;

  Rarity({required this.name, required this.color});

  static fromJson(Map<String, dynamic> json) {
    return Rarity(name: json['name'], color: int.parse(json['color']));
  }

}