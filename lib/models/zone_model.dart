class Area {
  String id;
  String codigo;
  String descripcion;
  DateTime updatedAt;

  Area(
      {required this.id, required this.codigo, required this.descripcion, required this.updatedAt});

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['_id'] ?? map['id'] ?? '',
      codigo: map['codigo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static const String createZoneTable = '''
    CREATE TABLE areas(
        id TEXT PRIMARY KEY,
        codigo TEXT,
        descripcion TEXT,
        updatedAt TEXT
    )
  ''';
}
