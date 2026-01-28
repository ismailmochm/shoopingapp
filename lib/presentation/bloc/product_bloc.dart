import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;

  ProductBloc(this.repo) : super(const ProductState()) {
    on<FetchProducts>(_fetch);
    on<IncreaseQty>(_increase);
    on<DecreaseQty>(_decrease);
    on<ResetCart>(_reset);
    on<SortProducts>(_sort);
  }

  Future<void> _fetch(_, Emitter emit) async {
    emit(
      state.copyWith(
        products: [],
        originalProducts: [],
        loading: true,
        error: null,
      ),
    );
    try {
      final products = await repo.fetchProducts();

      emit(
        state.copyWith(
          products: products,
          originalProducts: products,
          loading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: 'Failed to load products. Please try again.',
        ),
      );
    }
  }

  void _increase(IncreaseQty event, Emitter<ProductState> emit) {
    final updatedProducts = state.products.map((product) {
      if (product.id == event.id && product.quantity < product.stock) {
        return product.copyWith(quantity: product.quantity + 1);
      }
      return product;
    }).toList();

    emit(ProductState(products: updatedProducts));
  }

  void _decrease(DecreaseQty event, Emitter<ProductState> emit) {
    final updatedProducts = state.products.map((product) {
      if (product.id == event.id && product.quantity > 0) {
        return product.copyWith(quantity: product.quantity - 1);
      }
      return product;
    }).toList();

    emit(ProductState(products: updatedProducts));
  }

  void _reset(_, Emitter emit) {
    emit(
      ProductState(
        products: state.products.map((e) => e.copyWith(quantity: 0)).toList(),
      ),
    );
  }

  void _sort(SortProducts event, Emitter emit) {
    List<ProductModel> sorted = [...state.products];

    switch (event.sortType) {
      case SortType.highestPrice:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortType.lowestPrice:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.name:
        sorted.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.defaultSort:
        sorted = state.originalProducts;
        break;
    }

    emit(state.copyWith(products: sorted, sortType: event.sortType));
  }
}
