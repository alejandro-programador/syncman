class Stock {
  final String id;
  final String almacen;
  final String articulo;
  final String tipo;
  final int stock;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Stock({
    required this.id,
    required this.almacen,
    required this.articulo,
    required this.tipo,
    required this.stock,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir el JSON a un modelo Stock
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['_id'],
      almacen: json['almacen'],
      articulo: json['articulo'],
      tipo: json['tipo'],
      stock: json['stock'] ?? 0,
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Convertir el modelo Stock a un mapa para insertarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'almacen': almacen,
      'articulo': articulo,
      'tipo': tipo,
      'stock': stock,
      'isDeleted': isDeleted ? 1 : 0, // Guardar como entero para SQLite
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
