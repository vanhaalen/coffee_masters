import 'package:coffee_masters/datamanager.dart';
import 'package:coffee_masters/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OrderPage extends StatefulWidget {
  final DataManager dataManager;

  const OrderPage({super.key, required this.dataManager});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataManager.cart.isEmpty) {
      return const Center(
        child: Text("No items in cart"),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dataManager.cart.length,
            itemBuilder: (context, index) {
              var item = widget.dataManager.cart[index];
              return OrderItem(
                item: item,
                onRemove: (product) {
                  setState(() {
                    widget.dataManager.cartRemove(product);
                  });
                },
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${widget.dataManager.cartTotal().toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final ItemInCart item;
  final Function onRemove;
  const OrderItem({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${item.quantity}x"),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  item.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 2,
                child: Text(
                    "\$${(item.product.price * item.quantity).toStringAsFixed(2)}")),
            IconButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  onRemove(item.product);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
