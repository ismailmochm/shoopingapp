import '../models/product_model.dart';
import '../sources/product_remote_source.dart';

class ProductRepository {
  final ProductRemoteSource source;
  ProductRepository(this.source);

  Future<List<ProductModel>> fetchProducts() {
    return source.fetchProducts();
  }
}
