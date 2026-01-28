import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';

class ProductState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> originalProducts;
  final bool loading;
  final String? error;
  final SortType sortType;

  const ProductState({
    this.products = const [],
    this.originalProducts = const [],
    this.loading = false,
    this.error,
    this.sortType = SortType.defaultSort,
  });

  double get total => products.fold(0, (sum, p) => sum + p.price * p.quantity);

  int get totalQty => products.fold(0, (sum, p) => sum + p.quantity);

  String get totalFormatted => total
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.');

  ProductState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? originalProducts,
    bool? loading,
    String? error,
    SortType? sortType,
  }) {
    return ProductState(
      products: products ?? this.products,
      originalProducts: originalProducts ?? this.originalProducts,
      loading: loading ?? this.loading,
      error: error,
      sortType: sortType ?? this.sortType,
    );
  }

  bool get hasError => error != null;

  @override
  List<Object?> get props => [products, loading];
}

enum SortType { defaultSort, highestPrice, lowestPrice, name }

extension SortTypeLabel on SortType {
  String get label {
    switch (this) {
      case SortType.highestPrice:
        return 'Highest Price';
      case SortType.lowestPrice:
        return 'Lowest Price';
      case SortType.name:
        return 'Name';
      case SortType.defaultSort:
        return 'Default';
    }
  }
}
