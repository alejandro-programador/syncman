import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';

class SubLinea {
  final String id;
  final String codigo;
  final String descripcion;
  final int comiSubLin;
  final int comiSubLin2;
  final String iSubLinDes;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  SubLinea({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.comiSubLin,
    required this.comiSubLin2,
    required this.iSubLinDes,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convertir el JSON a un modelo SubLinea
  factory SubLinea.fromJson(Map<String, dynamic> json) {
    List<DatoAdicional> parseDatosAdicionales(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          final List<dynamic> decoded = jsonDecode(value);
          return decoded.map((dato) => DatoAdicional.fromJson(dato)).toList();
        } catch (e) {
          print('Error parsing datosAdicionales in SubLinea: $e');
          return [];
        }
      }
      if (value is List) {
        return value.map((dato) => DatoAdicional.fromJson(dato)).toList();
      }
      return [];
    }

    return SubLinea(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      comiSubLin: json['comiSubLin'] ?? 0,
      comiSubLin2: json['comiSubLin2'] ?? 0,
      iSubLinDes: json['iSubLinDes'] ?? '',
      datosAdicionales: parseDatosAdicionales(json['datosAdicionales']),
      isDeleted: json['isDeleted'] == 1 || json['isDeleted'] == true,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  // Convertir el modelo SubLinea a un mapa para insertarlo en SQLite
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'comiSubLin': comiSubLin,
      'comiSubLin2': comiSubLin2,
      'iSubLinDes': iSubLinDes,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0, // SQLite no maneja booleanos
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
