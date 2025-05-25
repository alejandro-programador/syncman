import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class ColorModel {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  ColorModel({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> datosAdicionalesRaw;
    if (json['datosAdicionales'] is String) {
      try {
        datosAdicionalesRaw = jsonDecode(json['datosAdicionales']);
      } catch (e) {
        print('Error parsing datosAdicionales: $e');
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

    return ColorModel(
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

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
