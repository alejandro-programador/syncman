import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class Category {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir el JSON a un modelo Category
  factory Category.fromJson(Map<String, dynamic> json) {
    List<dynamic> datosAdicionalesRaw;
    if (json['datosAdicionales'] is String) {
      try {
        datosAdicionalesRaw = jsonDecode(json['datosAdicionales']);
      } catch (e) {
        datosAdicionalesRaw = [];
      }
    } else if (json['datosAdicionales'] is List) {
      datosAdicionalesRaw = json['datosAdicionales'];
    } else {
      datosAdicionalesRaw = [];
    }

    var datosAdicionalesFromJson = datosAdicionalesRaw
        .map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList();

    return Category(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      datosAdicionales: datosAdicionalesFromJson,
      isDeleted: json['isDeleted'] == 1,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Convertir el modelo Category a un mapa para insertarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'datosAdicionales': jsonEncode(datosAdicionales
          .map((dato) => dato.toMap())
          .toList()), // Convertido a JSON
      'isDeleted': isDeleted ? 1 : 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static const String createCategoryTable = '''
    CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      _id TEXT UNIQUE,
      codigo TEXT,
      descripcion TEXT,
      datosAdicionales TEXT, -- Se almacena como JSON
      isDeleted INTEGER DEFAULT 0,
      createdAt TEXT,
      updatedAt TEXT
    )
  ''';
}
