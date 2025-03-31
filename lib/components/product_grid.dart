import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:shop/models/product_list.dart';
import '../components/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteonly;

  const ProductGrid(this.showFavoriteonly, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = showFavoriteonly ? provider.favorite_items : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: ProductItem()
        ),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6 / 10.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 30
      )
    );
  }
}