import 'payment_method_model.dart';
import 'bill_model.dart';
import 'client_model.dart';
import 'seller_model.dart';
import 'dart:convert';

class Collect {
  String? id;
  String? codigo;
  List<PaymentMethod>? metodosPago;
  double? tasa;
  double? tasaIva;
  List<Bill>? facturas;
  Client? cliente;
  Seller? vendedor;
  String? tipo;
  String? descripcion;
  bool? valija;
  List<String>? imagenes;
  List<String>? imagenesUrl;
  String? moneda;
  DateTime? fecha;
  String? estatus;
  double? total;
  bool? isDeleted;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Collect({
    this.id,
    this.codigo,
    this.metodosPago,
    this.tasa,
    this.tasaIva,
    this.facturas,
    this.cliente,
    this.vendedor,
    this.tipo,
    this.descripcion,
    this.valija,
    this.imagenes,
    this.imagenesUrl,
    this.moneda,
    this.fecha,
    this.estatus,
    this.total,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  // Collect vacío para cuando no se encuentre un collect
  static final emptyCollect = Collect(
    id: '',
    codigo: '',
    metodosPago: [],
    tasa: 0.0,
    tasaIva: 0.0,
    facturas: [],
    cliente: Client.emptyClient,
    vendedor: null,
    tipo: '',
    descripcion: '',
    valija: false,
    imagenes: [],
    imagenesUrl: [],
    moneda: '',
    fecha: DateTime.now(),
    estatus: 'Pendiente',
    total: 0.0,
    isDeleted: false,
  );

  factory Collect.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    List<String> parseStringList(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        return value.isEmpty ? [] : value.split(',');
      }
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return [];
    }

    List<PaymentMethod> parsePaymentMethods(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          final List<dynamic> decoded = jsonDecode(value);
          return decoded.map((e) => PaymentMethod.fromMap(e)).toList();
        } catch (e) {
          print('Error parsing payment methods: $e');
          return [];
        }
      }
      if (value is List) {
        return value.map((e) => PaymentMethod.fromMap(e)).toList();
      }
      return [];
    }

    List<Bill> parseBills(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          final List<dynamic> decoded = jsonDecode(value);
          return decoded.map((e) => Bill.fromMap(e)).toList();
        } catch (e) {
          print('Error parsing bills: $e');
          return [];
        }
      }
      if (value is List) {
        return value.map((e) => Bill.fromMap(e)).toList();
      }
      return [];
    }

    Client? parseClient(dynamic value) {
      if (value == null) return null;
      if (value is String) {
        try {
          final Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(value));
          return Client.fromMap(decoded);
        } catch (e) {
          print('Error parsing client: $e');
          return null;
        }
      }
      if (value is Map) {
        return Client.fromMap(Map<String, dynamic>.from(value));
      }
      return null;
    }

    Seller? parseSeller(dynamic value) {
      if (value == null) return null;
      if (value is String) {
        try {
          final Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(value));
          return Seller.fromMap(decoded);
        } catch (e) {
          print('Error parsing seller: $e');
          return null;
        }
      }
      if (value is Map) {
        return Seller.fromMap(Map<String, dynamic>.from(value));
      }
      return null;
    }

    return Collect(
      id: map['_id'],
      codigo: map['codigo'],
      metodosPago: parsePaymentMethods(map['metodosPago']),
      tasa: parseDouble(map['tasa']),
      tasaIva: parseDouble(map['tasaIva']),
      facturas: parseBills(map['facturas']),
      cliente: parseClient(map['cliente']),
      vendedor: parseSeller(map['vendedor']),
      tipo: map['tipo'],
      descripcion: map['descripcion'],
      valija: map['valija'] == 1,
      imagenes: parseStringList(map['imagenes']),
      imagenesUrl: parseStringList(map['imagenesUrl']),
      moneda: map['moneda'],
      fecha: map['fecha'] != null ? DateTime.parse(map['fecha']) : null,
      estatus: map['estatus'],
      total: parseDouble(map['total']),
      isDeleted: map['isDeleted'] == 1,
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'metodosPago': metodosPago != null ? jsonEncode(metodosPago!.map((e) => e.toMap()).toList()) : null,
      'tasa': tasa,
      'tasaIva': tasaIva,
      'facturas': facturas != null ? jsonEncode(facturas!.map((e) => e.toMap()).toList()) : null,
      'cliente': cliente != null ? jsonEncode(cliente!.toMap()) : null,
      'vendedor': vendedor != null ? jsonEncode(vendedor!.toMap()) : null,
      'tipo': tipo,
      'descripcion': descripcion,
      'valija': valija == true ? 1 : 0,
      'imagenes': imagenes?.join(','),
      'imagenesUrl': imagenesUrl?.join(','),
      'moneda': moneda,
      'fecha': fecha?.toIso8601String(),
      'estatus': estatus,
      'total': total,
      'isDeleted': isDeleted == true ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createCollectTable = '''
    CREATE TABLE collects (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      metodosPago TEXT,
      tasa REAL DEFAULT 0,
      tasaIva REAL DEFAULT 0,
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
      estatus TEXT DEFAULT 'Pendiente',
      total REAL DEFAULT 0,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
} 