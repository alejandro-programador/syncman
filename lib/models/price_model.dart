class Price {
  final String id;
  final String articulo;
  final String almacen;
  final String tipoPrecio;
  final String? almacenCalculado;
  final String createdAt;
  final String? deletedAt;
  final String desde;
  final String? hasta;
  final bool isDeleted;
  final String moneda;
  final double monto;
  final double montoAdicional1;
  final double montoAdicional2;
  final double montoAdicional3;
  final double montoAdicional4;
  final double montoAdicional5;
  final bool precioOm;
  final String updatedAt;

  Price({
    required this.id,
    required this.articulo,
    required this.almacen,
    required this.tipoPrecio,
    this.almacenCalculado,
    required this.createdAt,
    this.deletedAt,
    required this.desde,
    this.hasta,
    required this.isDeleted,
    required this.moneda,
    required this.monto,
    required this.montoAdicional1,
    required this.montoAdicional2,
    required this.montoAdicional3,
    required this.montoAdicional4,
    required this.montoAdicional5,
    required this.precioOm,
    required this.updatedAt,
  });

  // Convertir JSON a un objeto Price
  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['_id'],
      articulo: json['articulo'],
      almacen: json['almacen'],
      tipoPrecio: json['tipoPrecio'],
      almacenCalculado: json['almacenCalculado'],
      createdAt: json['createdAt'],
      deletedAt: json['deletedAt'],
      desde: json['desde'],
      hasta: json['hasta'],
      isDeleted: json['isDeleted'] ?? false,
      moneda: json['moneda'],
      monto: (json['monto'] as num?)?.toDouble() ?? 0.0, // Manejo de nulos
      montoAdicional1: (json['montoAdicional1'] as num?)?.toDouble() ?? 0.0,
      montoAdicional2: (json['montoAdicional2'] as num?)?.toDouble() ?? 0.0,
      montoAdicional3: (json['montoAdicional3'] as num?)?.toDouble() ?? 0.0,
      montoAdicional4: (json['montoAdicional4'] as num?)?.toDouble() ?? 0.0,
      montoAdicional5: (json['montoAdicional5'] as num?)?.toDouble() ?? 0.0,
      precioOm: json['precioOm'] ?? false,
      updatedAt: json['updatedAt'],
    );
  }

  // Convertir el objeto Price a un mapa para SQLite
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'articulo': articulo,
      'almacen': almacen,
      'tipoPrecio': tipoPrecio,
      'almacenCalculado': almacenCalculado,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'desde': desde,
      'hasta': hasta,
      'isDeleted': isDeleted ? 1 : 0, // SQLite no maneja booleanos
      'moneda': moneda,
      'monto': monto,
      'montoAdicional1': montoAdicional1,
      'montoAdicional2': montoAdicional2,
      'montoAdicional3': montoAdicional3,
      'montoAdicional4': montoAdicional4,
      'montoAdicional5': montoAdicional5,
      'precioOm': precioOm ? 1 : 0, // Booleano a entero para SQLite
      'updatedAt': updatedAt,
    };
  }

  static const String createPriceTable = '''
    CREATE TABLE prices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    _id TEXT UNIQUE,
    articulo TEXT,
    tipoPrecio TEXT,
    almacen TEXT,
    almacenCalculado TEXT,
    monto REAL,
    desde TEXT,
    hasta TEXT,
    montoAdicional1 REAL,
    montoAdicional2 REAL,
    montoAdicional3 REAL,
    montoAdicional4 REAL,
    montoAdicional5 REAL,
    precioOm INTEGER,
    moneda TEXT,
    isDeleted INTEGER,
    deletedAt TEXT,
    createdAt TEXT,
    updatedAt TEXT
  )
  ''';
}
