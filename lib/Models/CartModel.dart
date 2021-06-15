import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int price;
  final int quantity;
  final String img;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity,
      @required this.img});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

// isme sirf Item count hoga duplicate nhi
  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

// isme qty count bhi milega
  int get qtyCount {
    int qt = 0;
    _items.forEach((key, value) {
      qt += value.quantity;
    });
    return qt;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String id, int price, String title, String img) {
    if (_items.containsKey(id)) {
      //Change Quantitiy
      _items.update(
          id,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              img: existingItem.img,
              quantity: existingItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                img: img,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void addSingleItem(String id) {
    if (!_items.containsKey(id)) return;

    _items.update(
        id,
        (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            price: existingItem.price,
            quantity: existingItem.quantity + 1,
            img: existingItem.img));

    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;

    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity - 1,
              img: existingItem.img));
    } else
      _items.remove(id);
    notifyListeners();
  }

  void removeItem(String prodid) {
    _items.remove(prodid);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
