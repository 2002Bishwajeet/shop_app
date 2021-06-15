import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

List<String> company = [
  "Nike",
  "Adidas",
  "Puma",
  "Bata",
  "Reebok",
  "RedTape",
  "Campus",
];

class ShoesDetails with ChangeNotifier {
  final String id;
  final int amount;
  bool isFavorite = false;
  final String img;
  final String title;
  final String description;
  final String subtitle;
  final String brand;
  ShoesDetails({
    @required this.id,
    @required this.amount,
    @required this.isFavorite,
    @required this.img,
    @required this.title,
    @required this.description,
    @required this.subtitle,
    @required this.brand,
  });

  void _setFave(bool newvalue) {
    isFavorite = newvalue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners(); // equivalent to setstate and stateful iss bas widget rebuild
    final url = Uri.parse(
        "https://[project-name]-default-rtdb.asia-southeast1.firebasedatabase.app/Shoes/$id.json?auth=$token");
    try {
      final response = await http.patch(url, //patch for updating data
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        _setFave(oldStatus);
      }
    } catch (error) {
      _setFave(oldStatus);
    }
  }
}
