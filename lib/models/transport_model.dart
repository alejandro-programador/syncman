import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class Transport {
  final String id;
  final String codigo;
  final String descripcion;
  final String respTra;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Transport({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.respTra,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir de Map a objeto Transport
  factory Transport.fromJson(Map<String, dynamic> json) {
    var datosAdicionalesFromJson = (json['datosAdicionales'] as List)
        .map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList();

    return Transport(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      respTra: json['respTra'],
      datosAdicionales: datosAdicionalesFromJson,
      isDeleted: json['isDeleted'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Convertir un objeto Transport a un mapa para SQLite
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'respTra': respTra,
      'isDeleted': isDeleted ? 1 : 0, // Cambiado a 1 o 0 para base de datos
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
    };
  }

  static const String createTransportTable = '''
    CREATE TABLE transportes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT UNIQUE,
        codigo TEXT,
        descripcion TEXT,
        respTra TEXT,
        datosAdicionales TEXT, -- Se almacena como JSON
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
  ''';
}
