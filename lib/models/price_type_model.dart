import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';

class PriceType {
  final String id;
  final String codigo;
  final String descripcion;
  final bool incluyeImp;
  final bool almTemp;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  PriceType({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.incluyeImp,
    required this.almTemp,
    required this.datosAdicionales,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PriceType.fromJson(Map<String, dynamic> json) {
    var datosAdicionalesFromJson = (json['datosAdicionales'] as List)
        .map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList();

    return PriceType(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      incluyeImp: json['incluyeImp'] ?? false,
      almTemp: json['almTemp'] ?? false,
      datosAdicionales: datosAdicionalesFromJson,
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'incluyeImp': incluyeImp ? 1 : 0,
      'almTemp': almTemp ? 1 : 0,
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
