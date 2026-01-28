import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final int stock;
  final String thumbnail;
  final int quantity;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.thumbnail,
    this.quantity = 0,
  });

  ProductModel copyWith({int? quantity}) {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      stock: stock,
      thumbnail: thumbnail,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }

  @override
  List<Object?> get props => [id, quantity];
}
