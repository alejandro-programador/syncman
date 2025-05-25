import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';

class Ubication {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Ubication({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ubication.fromJson(Map<String, dynamic> json) {
    List<DatoAdicional> datosAdicionalesFromJson = [];
    
    if (json['datosAdicionales'] != null) {
      if (json['datosAdicionales'] is String) {
        try {
          final List<dynamic> decodedData = jsonDecode(json['datosAdicionales']);
          datosAdicionalesFromJson = decodedData
              .map((datoJson) => DatoAdicional.fromJson(datoJson))
              .toList();
        } catch (e) {
          print('Error decoding datosAdicionales: $e');
          datosAdicionalesFromJson = [];
        }
      } else if (json['datosAdicionales'] is List) {
        datosAdicionalesFromJson = (json['datosAdicionales'] as List)
            .map((datoJson) => DatoAdicional.fromJson(datoJson))
            .toList();
      }
    }

    return Ubication(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      datosAdicionales: datosAdicionalesFromJson,
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
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
