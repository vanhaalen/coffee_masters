import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/datamodel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
          future: dataManager.getMenu(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Category> menu = snapshot.data!;
              return ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, categoryIndex) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(menu[categoryIndex].name),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: menu[categoryIndex].products.length,
                        itemBuilder: (context, productIndex) {
                          var product =
                              menu[categoryIndex].products[productIndex];
                          return ProductItem(
                            product: product,
                            onAdd: (addedProduct) {
                              dataManager.cartAdd(addedProduct);
                            },
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text("${product.name} added to cart"),
                          //     duration: const Duration(seconds: 1),
                          //   ),
                          // );
                        },
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          })),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const ProductItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Text("\$${product.price.toStringAsFixed(2)}"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onAdd(product);
                    },
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
