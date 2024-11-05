import 'dart:convert';

class CartItem {
  final int id;
  final String name;
  final String price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl, // Include imageUrl in the constructor
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl, // Keep the imageUrl the same
    );
  }

  static List<CartItem> decodeList(String cartString) {
    return (json.decode(cartString) as List<dynamic>)
        .map((item) => CartItem.fromJson(item))
        .toList();
  }

  static String encodeList(List<CartItem> cart) {
    return json.encode(cart.map((item) => item.toJson()).toList());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'imageUrl': imageUrl, // Add imageUrl to the JSON representation
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['imageUrl'], // Read imageUrl from JSON
    );
  }
}
