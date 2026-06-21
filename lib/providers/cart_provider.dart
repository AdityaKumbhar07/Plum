import 'package:flutter/material.dart';

/// In-memory cart item used during bill creation
class CartItem {
  String name;
  double quantity;
  double unitPrice;

  CartItem({
    required this.name,
    required this.unitPrice,
    this.quantity = 1,
  });

  double get total => quantity * unitPrice;
}

/// Manages the bill creation cart — items added, totals, etc.
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  int? _selectedCustomerId;
  String? _selectedCustomerName;

  List<CartItem> get items => List.unmodifiable(_items);
  int? get selectedCustomerId => _selectedCustomerId;
  String? get selectedCustomerName => _selectedCustomerName;
  bool get hasCustomer => _selectedCustomerId != null;
  bool get hasItems => _items.isNotEmpty;
  bool get isReadyToGenerate => hasCustomer && hasItems;

  double get grandTotal => _items.fold(0, (sum, item) => sum + item.total);

  void selectCustomer(int id, String name) {
    _selectedCustomerId = id;
    _selectedCustomerName = name;
    notifyListeners();
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  /// Add a saved item with default price (the one-tap add)
  void addSavedItem(String name, double defaultPrice) {
    // Check if item already exists — if so, increment qty
    final existingIndex = _items.indexWhere((i) => i.name == name);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(name: name, unitPrice: defaultPrice));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, double quantity) {
    _items[index].quantity = quantity;
    notifyListeners();
  }

  void updatePrice(int index, double price) {
    _items[index].unitPrice = price;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _selectedCustomerId = null;
    _selectedCustomerName = null;
    notifyListeners();
  }
}
