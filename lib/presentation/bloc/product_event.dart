import 'package:shoppingapp/presentation/bloc/product_state.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class IncreaseQty extends ProductEvent {
  final int id;
  IncreaseQty(this.id);
}

class DecreaseQty extends ProductEvent {
  final int id;
  DecreaseQty(this.id);
}

class ResetCart extends ProductEvent {}

class SortProducts extends ProductEvent {
  final SortType sortType;
  SortProducts(this.sortType);
}
