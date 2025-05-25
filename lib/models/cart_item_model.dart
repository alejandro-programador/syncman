class CartItem {
  final String clientId;
  final String productId;
  final String productName;
  final String productCode;
  final String category;
  final int stock;
  final List<dynamic> unidades;
  final int quantity;
  final String tipoImp;
  final int taxRate;

  CartItem({
    required this.clientId,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.category,
    required this.stock,
    required this.unidades,
    required this.quantity,
    required this.tipoImp,
    required this.taxRate,
  });

  // Convert CartItem to Map
  Map<String, dynamic> toMap() {
    return {
      'client_id': clientId,
      'productID': productId,
      'productName': productName,
      'productCode': productCode,
      'category': category,
      'stock': stock,
      'unidades': unidades,
      'quantity': quantity,
      'tipoImp': tipoImp,
      'taxRate': taxRate,
    };
  }

  // Create CartItem from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      clientId: map['client_id'] ?? '',
      productId: map['productID'] ?? '',
      productName: map['productName'] ?? '',
      productCode: map['productCode'] ?? '',
      category: map['category'] ?? '',
      stock: map['stock'] ?? 0,
      unidades: map['unidades'] ?? [],
      quantity: map['quantity'] ?? 0,
      tipoImp: map['tipoImp'] ?? '',
      taxRate: map['taxRate'] ?? 0,
    );
  }

  // Create a copy of CartItem with some fields updated
  CartItem copyWith({
    String? clientId,
    String? productId,
    String? productName,
    String? productCode,
    String? category,
    int? stock,
    List<dynamic>? unidades,
    int? quantity,
    String? tipoImp,
    int? taxRate,
  }) {
    return CartItem(
      clientId: clientId ?? this.clientId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      unidades: unidades ?? this.unidades,
      quantity: quantity ?? this.quantity,
      tipoImp: tipoImp ?? this.tipoImp,
      taxRate: taxRate ?? this.taxRate,
    );
  }
} 