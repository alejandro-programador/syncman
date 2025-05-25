import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';

class Origin {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Origin({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    List<DatoAdicional> parseDatosAdicionales(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          final List<dynamic> decoded = jsonDecode(value);
          return decoded.map((dato) => DatoAdicional.fromJson(dato)).toList();
        } catch (e) {
          print('Error parsing datosAdicionales in Origin: $e');
          return [];
        }
      }
      if (value is List) {
        return value.map((dato) => DatoAdicional.fromJson(dato)).toList();
      }
      return [];
    }

    return Origin(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      datosAdicionales: parseDatosAdicionales(json['datosAdicionales']),
      isDeleted: json['isDeleted'] is int ? json['isDeleted'] == 1 : json['isDeleted'] ?? false,
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
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
