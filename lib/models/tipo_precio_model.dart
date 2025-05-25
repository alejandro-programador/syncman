import 'additional_model.dart';

class TipoPrecio {
  String? id;
  String? codigo;
  String? descripcion;
  bool? incluyeImp;
  bool? almTemp;
  List<DatoAdicional>? datosAdicionales;
  bool? isDeleted;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  TipoPrecio({
    this.id,
    this.codigo,
    this.descripcion,
    this.incluyeImp,
    this.almTemp,
    this.datosAdicionales,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // TipoPrecio vacío para cuando no se encuentre un tipo de precio
  static final emptyTipoPrecio = TipoPrecio(
    id: '',
    codigo: '',
    descripcion: '',
    incluyeImp: false,
    almTemp: false,
    datosAdicionales: [],
    isDeleted: false,
  );

  // Convertir un mapa (desde la BD) a un objeto TipoPrecio
  factory TipoPrecio.fromMap(Map<String, dynamic> map) {
    List<DatoAdicional> parseDatosAdicionales(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => DatoAdicional.fromJson(e)).toList();
      }
      return [];
    }

    return TipoPrecio(
      id: map['_id'],
      codigo: map['codigo'],
      descripcion: map['descripcion'],
      incluyeImp: map['incluyeImp'] ?? false,
      almTemp: map['almTemp'] ?? false,
      datosAdicionales: parseDatosAdicionales(map['datosAdicionales']),
      isDeleted: map['isDeleted'] == 1,
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convertir un objeto TipoPrecio a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'incluyeImp': incluyeImp,
      'almTemp': almTemp,
      'datosAdicionales': datosAdicionales?.map((e) => e.toMap()).toList(),
      'isDeleted': isDeleted == true ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createTipoPrecioTable = '''
    CREATE TABLE tipo_precios (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      descripcion TEXT,
      incluyeImp INTEGER DEFAULT 0,
      almTemp INTEGER DEFAULT 0,
      datosAdicionales TEXT,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
} 