class CollectPaymentMethod {
  String? id;
  String? descripcion;
  bool? cuenta;
  bool? sincronizado;
  bool? isDeleted;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  CollectPaymentMethod({
    this.id,
    this.descripcion,
    this.cuenta,
    this.sincronizado,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // Método de pago vacío para cuando no se encuentre uno
  static final emptyPaymentMethod = CollectPaymentMethod(
    id: '',
    descripcion: '',
    cuenta: false,
    sincronizado: false,
    isDeleted: false,
  );

  // Convertir un mapa (desde la BD) a un objeto CollectPaymentMethod
  factory CollectPaymentMethod.fromMap(Map<String, dynamic> map) {
    return CollectPaymentMethod(
      id: map['_id'],
      descripcion: map['descripcion'],
      cuenta: map['cuenta'] == 1,
      sincronizado: map['sincronizado'] == 1,
      isDeleted: map['isDeleted'] == 1,
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convertir un objeto CollectPaymentMethod a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'descripcion': descripcion,
      'cuenta': cuenta == true ? 1 : 0,
      'sincronizado': sincronizado == true ? 1 : 0,
      'isDeleted': isDeleted == true ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createPaymentMethodTable = '''
    CREATE TABLE collect_payment_methods (
      _id TEXT PRIMARY KEY,
      descripcion TEXT,
      cuenta INTEGER DEFAULT 0,
      sincronizado INTEGER DEFAULT 0,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
}