import '../models/product_model.dart';
import '../../core/network/dio_client.dart';

class ProductRemoteSource {
  final DioClient client;
  ProductRemoteSource(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    final res = await client.dio.get('/products');
    return (res.data['products'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
