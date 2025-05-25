import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';

class PaymentCondition {
  final String id;
  final String codigo;
  final String descripcion;
  final int diasCred;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  PaymentCondition({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.diasCred,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentCondition.fromJson(Map<String, dynamic> json) {
    var datosAdicionalesFromJson = (json['datosAdicionales'] as List)
        .map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList();

    return PaymentCondition(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      diasCred: json['diasCred'],
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
      'diasCred': diasCred,
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static const String createPaymentConditionTable = '''
    CREATE TABLE condicion_pagos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT UNIQUE,
        codigo TEXT,
        descripcion TEXT,
        diasCred INTEGER,
        datosAdicionales TEXT, -- Se almacena como JSON
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
    )
  ''';
}
