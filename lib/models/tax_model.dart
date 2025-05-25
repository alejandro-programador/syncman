class Tax {
  final String id;
  final String fecha;
  final int rengNum;
  final String tipoImpuesto;
  final bool ventas;
  final bool compras;
  final bool consumoSuntuario;
  final double porcTasa;
  final double porcSuntuario;
  final bool isDeleted;
  final String? deletedAt;

  Tax({
    required this.id,
    required this.fecha,
    required this.rengNum,
    required this.tipoImpuesto,
    required this.ventas,
    required this.compras,
    required this.consumoSuntuario,
    required this.porcTasa,
    required this.porcSuntuario,
    required this.isDeleted,
    required this.deletedAt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['_id'],
      fecha: json['fecha'],
      rengNum: json['rengNum'],
      tipoImpuesto: json['tipoImpuesto'],
      ventas: json['ventas'],
      compras: json['compras'],
      consumoSuntuario: json['consumoSuntuario'],
      porcTasa: json['porcTasa'] is int ? json['porcTasa'].toDouble() : json['porcTasa'],
      porcSuntuario: json['porcSuntuario'] is int ? json['porcSuntuario'].toDouble() : json['porcSuntuario'],
      isDeleted: json['isDeleted'],
      deletedAt: json['deletedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'fecha': fecha,
      'rengNum': rengNum,
      'tipoImpuesto': tipoImpuesto,
      'ventas': ventas ? 1 : 0,
      'compras': compras ? 1 : 0,
      'consumoSuntuario': consumoSuntuario ? 1 : 0,
      'porcTasa': porcTasa,
      'porcSuntuario': porcSuntuario,
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
    };
  }

  static const String createTaxTable = '''
    CREATE TABLE impuestos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT,
        fecha TEXT,
        rengNum INTEGER,
        tipoImpuesto TEXT,
        ventas INTEGER DEFAULT 0,
        compras INTEGER DEFAULT 0,
        consumoSuntuario INTEGER DEFAULT 0,
        porcTasa REAL,
        porcSuntuario REAL,
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT
    )
  ''';
  
} 