import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/models/return_product_model.dart';

class ReturnRecord {
  final String id;
  final String codigo;
  final Seller vendedor;
  final Client cliente;
  final Bill factura;
  final List<ReturnProduct> productos;
  final double iva;
  final double subtotal;
  final double total;
  final List<String> imagenes;
  final String observacion;
  final String motivo;
  final String desMotivo;
  final String descripcion;
  final String estatus;
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReturnRecord({
    required this.id,
    required this.codigo,
    required this.vendedor,
    required this.cliente,
    required this.factura,
    required this.productos,
    required this.iva,
    required this.subtotal,
    required this.total,
    required this.imagenes,
    required this.observacion,
    required this.motivo,
    required this.desMotivo,
    required this.descripcion,
    required this.estatus,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturnRecord.fromJson(Map<String, dynamic> json) {
    return ReturnRecord(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      vendedor: Seller.fromMap(json['vendedor'] ?? {}),
      cliente: Client.fromMap(json['cliente'] ?? {}),
      factura: Bill.fromMap(json['factura'] ?? {}),
      productos: (json['productos'] as List?)
          ?.map((product) => ReturnProduct.fromJson(product))
          .toList() ?? [],
      iva: (json['iva'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      imagenes: List<String>.from(json['imagenes'] ?? []),
      observacion: json['observacion'] ?? '',
      motivo: json['motivo'] ?? '',
      desMotivo: json['desMotivo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      estatus: json['estatus'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'codigo': codigo,
      'vendedor': vendedor.toMap(),
      'cliente': cliente.toMap(),
      'factura': factura.toMap(),
      'productos': productos.map((product) => product.toJson()).toList(),
      'iva': iva,
      'subtotal': subtotal,
      'total': total,
      'imagenes': imagenes,
      'observacion': observacion,
      'motivo': motivo,
      'desMotivo': desMotivo,
      'descripcion': descripcion,
      'estatus': estatus,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static const String createReturnRecordTable = '''
    CREATE TABLE return_records (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      vendedor TEXT,
      cliente TEXT,
      factura TEXT,
      productos TEXT,
      iva REAL DEFAULT 0,
      subtotal REAL DEFAULT 0,
      total REAL DEFAULT 0,
      imagenes TEXT,
      observacion TEXT,
      motivo TEXT,
      desMotivo TEXT,
      descripcion TEXT,
      estatus TEXT,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
} 