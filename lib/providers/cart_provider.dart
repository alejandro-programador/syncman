import 'package:flutter/material.dart';
import 'package:syncman_new/models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, dynamic> _client = {};
  bool _isLoading = false;
  num _totalBruto = 0;
  List<CartItem> _cartItems = [];

  Map<String, dynamic> get client => _client;
  bool get isLoading => _isLoading;
  num get totalBruto => _totalBruto;
  List<CartItem> get cartItems => _cartItems;

  CartProvider();

  void updateTotalBruto(num total) {
    _totalBruto = total;
    notifyListeners();
  }

  Future<void> saveUserSelected(Map<String, dynamic> client) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Save client code, name
      _client = client;
    } catch (e) {
      throw Exception('Error saveUserSelected: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProductToCart(Map<String, dynamic> productData) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Create a new CartItem from the product data
      final cartItem = CartItem(
        clientId: productData['client_id'],
        productId: productData['productID'],
        productName: productData['productName'],
        productCode: productData['productCode'],
        category: productData['category'],
        stock: productData['stock'],
        unidades: productData['unidades'],
        quantity: productData['quantity'],
        tipoImp: productData['tipoImp'],
        taxRate: productData['taxRate'],
      );

      print('=== Adding Product to Cart ===');
      print('Product Data: ${cartItem.toMap()}');

      // Check if product already exists in cart
      final existingProductIndex = _cartItems.indexWhere(
        (item) => item.productCode == cartItem.productCode
      );

      if (existingProductIndex != -1) {
        // Update quantity if product exists
        _cartItems[existingProductIndex] = _cartItems[existingProductIndex].copyWith(
          quantity: _cartItems[existingProductIndex].quantity + cartItem.quantity
        );
        print('Product updated in cart. New quantity: ${_cartItems[existingProductIndex].quantity}');
      } else {
        // Add new product if it doesn't exist
        _cartItems.add(cartItem);
        print('New product added to cart');
      }

      // Verify data was saved
      print('=== Cart Items After Update ===');
      print('Total items in cart: ${_cartItems.length}');
      for (var item in _cartItems) {
        print('Item: ${item.productName} - Quantity: ${item.quantity}');
      }

      // Recalculate total
      await calculateTotalBruto(_cartItems);
      print('New total: $_totalBruto');
    } catch (e) {
      print('Error adding product to cart: $e');
      throw Exception('Error adding product to cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateTotalBruto(List<CartItem> cartList) async {
    _isLoading = true;
    notifyListeners();

    try {
      num total = 0;

      for (var item in cartList) {
        final List unidades = item.unidades;
        final int quantity = item.quantity;

        for (var unidad in unidades) {
          final int unidadEquivalencia = unidad['equivalencia'];
          final bool unidadInversa = unidad['inversa'];

          // Add to total based on quantity only
          total += unidadEquivalencia * quantity;
        }
      }

      _totalBruto = total;
    } catch (e) {
      throw Exception('Error when obtain totalBruto: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
