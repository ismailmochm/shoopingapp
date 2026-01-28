import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/core/di/injection.dart';
import 'package:shoppingapp/core/widgets/loader.dart';
import 'package:shoppingapp/presentation/bloc/product_bloc.dart';
import 'package:shoppingapp/presentation/bloc/product_event.dart';
import 'package:shoppingapp/presentation/widgets/error_view.dart';
import '../bloc/product_state.dart';
import '../widgets/header.dart';
import '../widgets/product_item.dart';
import '../widgets/sort_menu.dart';
import '../widgets/footer.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(FetchProducts()),
      child: Scaffold(
        appBar: const Header(),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (_, state) {
            if (state.loading) {
              return const Loader();
            }

            if (state.hasError) {
              return ErrorView(message: state.error!);
            }

            return Column(
              children: [
                const SortMenu(),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (_, i) => ProductItem(state.products[i]),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (prev, curr) => prev.total != curr.total,
          builder: (_, state) => Footer(total: state.total),
        ),
      ),
    );
  }
}
