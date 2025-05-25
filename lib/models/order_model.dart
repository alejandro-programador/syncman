import 'dart:convert';
import 'package:syncman_new/models/additional_model.dart';
import 'package:syncman_new/models/renglon_model.dart';

class Order {
  final String id;
  final String codigo;
  final String descripcion;
  final String cliente;
  final String transporte;
  final String moneda;
  final String vendedor;
  final String condicionPago;
  final DateTime fecEmis;
  final DateTime fecVenc;
  final DateTime fecReg;
  final bool anulado;
  final String status;
  final String? nControl;
  final bool venTer;
  final double tasa;
  final double porcDescGlob;
  final double montoDescGlob;
  final double porcReca;
  final double montoReca;
  final double totalBruto;
  final double montoImp;
  final double montoImp2;
  final double montoImp3;
  final double otros1;
  final double otros2;
  final double otros3;
  final double totalNeto;
  final double saldo;
  final String? dirEnt;
  final String? comentario;
  final bool contrib;
  final bool impresa;
  final bool isDeleted;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DatoAdicional> datosAdicionales;
  final List<Renglon> renglones;

  Order({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.cliente,
    required this.transporte,
    required this.moneda,
    required this.vendedor,
    required this.condicionPago,
    required this.fecEmis,
    required this.fecVenc,
    required this.fecReg,
    required this.anulado,
    required this.status,
    this.nControl,
    required this.venTer,
    required this.tasa,
    required this.porcDescGlob,
    required this.montoDescGlob,
    required this.porcReca,
    required this.montoReca,
    required this.totalBruto,
    required this.montoImp,
    required this.montoImp2,
    required this.montoImp3,
    required this.otros1,
    required this.otros2,
    required this.otros3,
    required this.totalNeto,
    required this.saldo,
    this.dirEnt,
    this.comentario,
    required this.contrib,
    required this.impresa,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.datosAdicionales,
    required this.renglones,
  });

  factory Order.fromMap(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
      cliente: json['cliente'],
      transporte: json['transporte'],
      moneda: json['moneda'],
      vendedor: json['vendedor'],
      condicionPago: json['condicionPago'],
      fecEmis: DateTime.parse(json['fecEmis']),
      fecVenc: DateTime.parse(json['fecVenc']),
      fecReg: DateTime.parse(json['fecReg']),
      anulado: json['anulado'] == 1,
      status: json['status'] ?? '0',
      nControl: json['nControl'],
      venTer: json['venTer'] == 1,
      tasa: (json['tasa'] ?? 0).toDouble(),
      porcDescGlob: (json['porcDescGlob'] ?? 0).toDouble(),
      montoDescGlob: (json['montoDescGlob'] ?? 0).toDouble(),
      porcReca: (json['porcReca'] ?? 0).toDouble(),
      montoReca: (json['montoReca'] ?? 0).toDouble(),
      totalBruto: (json['totalBruto'] ?? 0).toDouble(),
      montoImp: (json['montoImp'] ?? 0).toDouble(),
      montoImp2: (json['montoImp2'] ?? 0).toDouble(),
      montoImp3: (json['montoImp3'] ?? 0).toDouble(),
      otros1: (json['otros1'] ?? 0).toDouble(),
      otros2: (json['otros2'] ?? 0).toDouble(),
      otros3: (json['otros3'] ?? 0).toDouble(),
      totalNeto: (json['totalNeto'] ?? 0).toDouble(),
      saldo: (json['saldo'] ?? 0).toDouble(),
      dirEnt: json['dirEnt'],
      comentario: json['comentario'],
      contrib: json['contrib'] == 1,
      impresa: json['impresa'] == 1,
      isDeleted: json['isDeleted'] == 1,
      deletedAt: json['deletedAt'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      datosAdicionales: json['datosAdicionales'] is List
          ? (json['datosAdicionales'] as List)
              .map((e) => DatoAdicional.fromJson(e))
              .toList()
          : [], // o manejar de otra forma el caso cuando no sea una lista
      renglones: json['renglones'] is List
          ? (json['renglones'] as List).map((e) => Renglon.fromJson(e)).toList()
          : [], // lo mismo aquí
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'cliente': cliente,
      'transporte': transporte,
      'moneda': moneda,
      'vendedor': vendedor,
      'condicionPago': condicionPago,
      'fecEmis': fecEmis.toIso8601String(),
      'fecVenc': fecVenc.toIso8601String(),
      'fecReg': fecReg.toIso8601String(),
      'anulado': anulado ? 1 : 0,
      'status': status,
      'nControl': nControl,
      'venTer': venTer ? 1 : 0,
      'tasa': tasa,
      'porcDescGlob': porcDescGlob,
      'montoDescGlob': montoDescGlob,
      'porcReca': porcReca,
      'montoReca': montoReca,
      'totalBruto': totalBruto,
      'montoImp': montoImp,
      'montoImp2': montoImp2,
      'montoImp3': montoImp3,
      'otros1': otros1,
      'otros2': otros2,
      'otros3': otros3,
      'totalNeto': totalNeto,
      'saldo': saldo,
      'dirEnt': dirEnt,
      'comentario': comentario,
      'contrib': contrib ? 1 : 0,
      'impresa': impresa ? 1 : 0,
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'datosAdicionales':
          jsonEncode(datosAdicionales.map((e) => e.toMap()).toList()),
      'renglones': jsonEncode(renglones.map((e) => e.toMap()).toList()),
    };
  }
}
