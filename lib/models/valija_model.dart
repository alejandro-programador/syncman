class Valija {
  String? id;
  String? codigo;
  String? vendedor;
  String? zona;
  List<String>? cobros;
  double? monto;
  double? montoBS;
  String? observacion;
  String? comentario;
  String? estatus;
  List<dynamic>? bauche;
  bool? sincronizado;
  bool? isDeleted;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Valija({
    this.id,
    this.codigo,
    this.vendedor,
    this.zona,
    this.cobros,
    this.monto,
    this.montoBS,
    this.observacion,
    this.comentario,
    this.estatus,
    this.bauche,
    this.sincronizado,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // Valija vacía para cuando no se encuentre una valija
  static final emptyValija = Valija(
    id: '',
    codigo: '',
    vendedor: '',
    zona: '',
    cobros: [],
    monto: 0.0,
    montoBS: 0.0,
    observacion: '',
    comentario: '',
    estatus: 'Pendiente',
    bauche: [],
    sincronizado: false,
    isDeleted: false,
  );

  // Convertir un mapa (desde la BD) a un objeto Valija
  factory Valija.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    List<String> parseStringList(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        return value.isEmpty ? [] : value.split(',');
      }
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return [];
    }

    return Valija(
      id: map['_id'],
      codigo: map['codigo'],
      vendedor: map['vendedor'],
      zona: map['zona'],
      cobros: parseStringList(map['cobros']),
      monto: parseDouble(map['monto']),
      montoBS: parseDouble(map['montoBS']),
      observacion: map['observacion'] ?? '',
      comentario: map['comentario'] ?? '',
      estatus: map['estatus'] ?? 'Pendiente',
      bauche: parseStringList(map['bauche']),
      sincronizado: map['sincronizado'] == 1,
      isDeleted: map['isDeleted'] == 1,
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convertir un objeto Valija a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'vendedor': vendedor,
      'zona': zona,
      'cobros': cobros?.join(','),
      'monto': monto,
      'montoBS': montoBS,
      'observacion': observacion,
      'comentario': comentario,
      'estatus': estatus,
      'bauche': bauche?.join(','),
      'sincronizado': sincronizado == true ? 1 : 0,
      'isDeleted': isDeleted == true ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createValijaTable = '''
    CREATE TABLE valijas (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      vendedor TEXT,
      zona TEXT,
      cobros TEXT,
      monto REAL DEFAULT 0,
      montoBS REAL DEFAULT 0,
      observacion TEXT,
      comentario TEXT,
      estatus TEXT DEFAULT 'Pendiente',
      bauche TEXT,
      sincronizado INTEGER DEFAULT 0,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
} 