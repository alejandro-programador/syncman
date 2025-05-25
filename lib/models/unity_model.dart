import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class Unidad {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Unidad({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unidad.fromJson(Map<String, dynamic> json) {
    var datosAdicionalesFromJson = (json['datosAdicionales'] as List)
        .map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList();

    return Unidad(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      datosAdicionales: datosAdicionalesFromJson,
      isDeleted: json['isDeleted'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'isDeleted': isDeleted ? 1 : 0, // Cambiado a 1 o 0 para base de datos
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
    };
  }
}
