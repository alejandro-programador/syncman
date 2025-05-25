import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class Currency {
  final String id;
  final String codigo;
  final String nombre;
  final double cambio;
  final bool relacion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Currency({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.cambio,
    required this.relacion,
    required this.datosAdicionales,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    List<DatoAdicional> datosAdicionalesFromJson;
    
    // Handle datosAdicionales from API (List) or database (JSON string)
    if (json['datosAdicionales'] is String) {
      // Parse JSON string from database
      final List<dynamic> decodedData = jsonDecode(json['datosAdicionales']);
      datosAdicionalesFromJson = decodedData
          .map((datoJson) => DatoAdicional.fromJson(datoJson))
          .toList();
    } else {
      // Handle data from API
      datosAdicionalesFromJson = (json['datosAdicionales'] as List)
          .map((datoJson) => DatoAdicional.fromJson(datoJson))
          .toList();
    }

    return Currency(
      id: json['_id'] ?? json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      cambio: json['cambio'] is int
          ? json['cambio'].toDouble()
          : json['cambio'],
      relacion: json['relacion'] is int ? json['relacion'] == 1 : json['relacion'],
      datosAdicionales: datosAdicionalesFromJson,
      isDeleted: json['isDeleted'] is int ? json['isDeleted'] == 1 : json['isDeleted'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'nombre': nombre,
      'cambio': cambio,
      'relacion': relacion ? 1 : 0,
      'datosAdicionales': jsonEncode(datosAdicionales
          .map((dato) => dato.toMap())
          .toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static const String createCurrencyTable = '''
    CREATE TABLE monedas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT UNIQUE,
        codigo TEXT,
        nombre TEXT,
        cambio REAL,
        relacion INTEGER,
        datosAdicionales TEXT,
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
    )
  ''';
}
