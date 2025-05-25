import 'dart:convert';

import 'package:syncman_new/models/configuration_data_model.dart';

class Configuration {
  final String id;
  final String nombre;
  final ConfigurationData configuracion;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Configuration({
    required this.id,
    required this.nombre,
    required this.configuracion,
    required this.createdAt,
    this.deletedAt,
    required this.isDeleted,
    required this.updatedAt,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      id: json['_id'],
      nombre: json['nombre'],
      configuracion: ConfigurationData.fromJson(json['configuracion']),
      isDeleted: json['isDeleted'],
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Para SQLite
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'configuracion': jsonEncode(configuracion.toMap()), // ✅ Aquí el cambio
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
