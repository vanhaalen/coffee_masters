import 'dart:convert';

import 'package:coffee_masters/datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = response.body;
      _menu = [];
      var decodeDate = jsonDecode(body) as List<dynamic>;
      for (var jsonCategory in decodeDate) {
        _menu!.add(Category.fromJson(jsonCategory));
      }
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product p) {
    bool found = false;
    for (var item in cart) {
      if (item.product.id == p.id) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      cart.add(ItemInCart(product: p, quantity: 1));
    }
  }

  cartRemove(Product p) {
    int indexToRemove = cart.indexWhere((item) => item.product.id == p.id);
    if (indexToRemove != -1) {
      if (cart[indexToRemove].quantity > 1) {
        cart[indexToRemove].quantity--;
      } else {
        cart.removeAt(indexToRemove);
      }
    }
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    double total = cart.fold(
        0, (value, item) => value + item.product.price * item.quantity);

    return total;
  }
}
