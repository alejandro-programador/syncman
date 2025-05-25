import 'dart:convert';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/models/payment_method_model.dart';

class Payment {
  final String id;
  final String codigo;
  final dynamic metodosPago; // Can be List<PaymentMethod> or String
  final dynamic tasa; // Can be double or String
  final dynamic tasaIva; // Can be double or String
  final dynamic facturas; // Can be List<Map<String, dynamic>> or String
  final dynamic cliente; // Can be Client or String
  final dynamic vendedor; // Can be Seller or String
  final String tipo;
  final String descripcion;
  final bool valija;
  final List<String> imagenes;
  final List<String> imagenesUrl;
  final String moneda;
  final DateTime fecha;
  final String estatus;
  final dynamic total; // Can be double or String
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final String? sucursal;

  Payment({
    required this.id,
    required this.codigo,
    required this.metodosPago,
    required this.tasa,
    required this.tasaIva,
    required this.facturas,
    required this.cliente,
    required this.vendedor,
    required this.tipo,
    required this.descripcion,
    required this.valija,
    required this.imagenes,
    required this.imagenesUrl,
    required this.moneda,
    required this.fecha,
    required this.estatus,
    required this.total,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.sucursal,
  });

  // Basic payment registration
  factory Payment.register({
    required String id,
    required String metodosPago,
    required String tasa,
    required String tasaIva,
    required String facturas,
    required String cliente,
    required String vendedor,
    required String tipo,
    required String descripcion,
    required String moneda,
    required String fecha,
    required String estatus,
    required String total,
    required String sucursal,
    required List<String> imagenes,
  }) {
    return Payment(
      id: id,
      codigo: id,
      metodosPago: metodosPago,
      tasa: tasa,
      tasaIva: tasaIva,
      facturas: facturas,
      cliente: cliente,
      vendedor: vendedor,
      tipo: tipo,
      descripcion: descripcion,
      valija: false,
      imagenes: imagenes,
      imagenesUrl: [],
      moneda: moneda,
      fecha: DateTime.parse(fecha),
      estatus: estatus,
      total: total,
      isDeleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isSynced: false,
      sucursal: sucursal,
    );
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    List<PaymentMethod> parseMetodosPago(dynamic value) {
      if (value is String) {
        return (jsonDecode(value) as List)
            .map((method) => PaymentMethod.fromMap(method))
            .toList();
      } else if (value is List) {
        return value.map((method) => PaymentMethod.fromMap(method)).toList();
      }
      return [];
    }

    List<Map<String, dynamic>> parseFacturas(dynamic value) {
      if (value is String) {
        return (jsonDecode(value) as List).cast<Map<String, dynamic>>();
      } else if (value is List) {
        return value.cast<Map<String, dynamic>>();
      }
      return [];
    }

    Map<String, dynamic> parseCliente(dynamic value) {
      if (value is String) {
        return jsonDecode(value);
      } else if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
      return {};
    }

    Map<String, dynamic> parseVendedor(dynamic value) {
      if (value is String) {
        return jsonDecode(value);
      } else if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
      return {};
    }

    List<String> parseImagenes(dynamic value) {
      if (value is String) {
        return (jsonDecode(value) as List).cast<String>();
      } else if (value is List) {
        return value.cast<String>();
      }
      return [];
    }

    bool parseBool(dynamic value) {
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        if (value == '1' || value.toLowerCase() == 'true') return true;
        if (value == '0' || value.toLowerCase() == 'false') return false;
      }
      return false;
    }

    return Payment(
      id: map['_id'] ?? '',
      codigo: map['codigo'] ?? '',
      metodosPago: map['metodosPago'],
      tasa: map['tasa'],
      tasaIva: map['tasaIva'],
      facturas: map['facturas'],
      cliente: map['cliente'],
      vendedor: map['vendedor'],
      tipo: map['tipo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      valija: parseBool(map['valija']),
      imagenes: parseImagenes(map['imagenes']),
      imagenesUrl: parseImagenes(map['imagenesUrl']),
      moneda: map['moneda'] ?? '',
      fecha: DateTime.parse(map['fecha']),
      estatus: map['estatus'] ?? '',
      total: map['total'],
      isDeleted: parseBool(map['isDeleted']),
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      isSynced: parseBool(map['isSynced']),
      sucursal: map['sucursal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'metodosPago': metodosPago is List ? jsonEncode(metodosPago.map((method) => method.toMap()).toList()) : metodosPago,
      'tasa': tasa,
      'tasaIva': tasaIva,
      'facturas': facturas is List ? jsonEncode(facturas) : facturas,
      'cliente': cliente is Client ? jsonEncode(cliente.toMap()) : cliente,
      'vendedor': vendedor is Seller ? jsonEncode(vendedor.toMap()) : vendedor,
      'tipo': tipo,
      'descripcion': descripcion,
      'valija': valija ? 1 : 0,
      'imagenes': jsonEncode(imagenes),
      'imagenesUrl': jsonEncode(imagenesUrl),
      'moneda': moneda,
      'fecha': fecha.toIso8601String(),
      'estatus': estatus,
      'total': total,
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced ? 1 : 0,
      'sucursal': sucursal,
    };
  }

  static const String createPaymentTable = '''
    CREATE TABLE payments (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      metodosPago TEXT,
      tasa TEXT,
      tasaIva TEXT,
      facturas TEXT,
      cliente TEXT,
      vendedor TEXT,
      tipo TEXT,
      descripcion TEXT,
      valija INTEGER DEFAULT 0,
      imagenes TEXT,
      imagenesUrl TEXT,
      moneda TEXT,
      fecha TEXT,
      estatus TEXT,
      total TEXT,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT,
      isSynced INTEGER DEFAULT 0,
      sucursal TEXT
    );
  ''';
} 