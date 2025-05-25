import 'package:syncman_new/models/unity_model.dart';

class UnidadArticulo {
  final String id;
  final Unidad unidad; // Aquí usas tu modelo existente
  final int equivalencia;
  final bool inversa;
  final bool? principalPrimaria;
  final bool? principal;
  final String updatedAt;
  final String createdAt;

  UnidadArticulo({
    required this.id,
    required this.unidad,
    required this.equivalencia,
    required this.inversa,
    this.principalPrimaria,
    this.principal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnidadArticulo.fromJson(Map<String, dynamic> json) {
    return UnidadArticulo(
      id: json['_id'],
      unidad: Unidad.fromJson(json['unidad']),
      equivalencia: json['equivalencia'],
      inversa: json['inversa'],
      principalPrimaria: json['principalPrimaria'],
      principal: json['principal'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'unidad': unidad.toMap(),
      'equivalencia': equivalencia,
      'inversa': inversa,
      'principalPrimaria': principalPrimaria,
      'principal': principal,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
