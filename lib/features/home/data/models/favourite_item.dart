import 'dart:convert';

import 'package:equatable/equatable.dart';

class FavoriteItem extends Equatable {
  final int id;
  final String name;
  final String img;
  final String price;
  final int quantity;

  const FavoriteItem({
    required this.id,
    required this.name,
    required this.img,
    required this.price,
    required this.quantity,
  });

  static List<FavoriteItem> decodeList(String favoritesString) {
    return (json.decode(favoritesString) as List<dynamic>)
        .map((item) => FavoriteItem.fromJson(item))
        .toList();
  }

  static String encodeList(List<FavoriteItem> favorites) {
    return json.encode(favorites.map((item) => item.toJson()).toList());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': img,
        'price': price,
        'quantity': quantity,
      };

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      name: json['name'],
      img: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  @override
  List<Object?> get props => [id, name, img, price, quantity];
}
