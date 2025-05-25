import 'dart:convert';

import 'package:syncman_new/models/additional_model.dart';

class Linea {
  final String id;
  final String codigo;
  final String descripcion;
  final int comiLin;
  final int comiLin2;
  final String iLinDes;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Linea({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.comiLin,
    required this.comiLin2,
    required this.iLinDes,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Linea.fromJson(Map<String, dynamic> json) {
    List<DatoAdicional> parseDatosAdicionales(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          final List<dynamic> decoded = jsonDecode(value);
          return decoded.map((dato) => DatoAdicional.fromJson(dato)).toList();
        } catch (e) {
          print('Error parsing datosAdicionales: $e');
          return [];
        }
      }
      if (value is List) {
        return value.map((dato) => DatoAdicional.fromJson(dato)).toList();
      }
      return [];
    }

    return Linea(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      comiLin: json['comiLin'] ?? 0,
      comiLin2: json['comiLin2'] ?? 0,
      iLinDes: json['iLinDes'] ?? '',
      datosAdicionales: parseDatosAdicionales(json['datosAdicionales']),
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'comiLin': comiLin,
      'comiLin2': comiLin2,
      'iLinDes': iLinDes,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
