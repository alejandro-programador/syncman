import 'dart:convert';

class Bill {
  final String? id;
  final String codigo;
  final String descripcion;
  final Map<String, dynamic> cliente;
  final String transporte;
  final Map<String, dynamic> moneda;
  final Map<String, dynamic> vendedor;
  final Map<String, dynamic> condicionPago;
  final String fecEmis;
  final String fecVenc;
  final String fecReg;
  final bool anulado;
  final String status;
  final String nControl;
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
  final String dirEnt;
  final String comentario;
  final bool contrib;
  final bool impresa;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> renglones;
  final List<Map<String, dynamic>> datosAdicionales;

  Bill({
    this.id,
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
    required this.nControl,
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
    required this.dirEnt,
    required this.comentario,
    required this.contrib,
    required this.impresa,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.renglones,
    required this.datosAdicionales,
  });

  // Convertir de un mapa de base de datos a un modelo Bill
  factory Bill.fromMap(Map<String, dynamic> map) {
    // Handle client data conversion
    Map<String, dynamic> clientData = {};
    if (map['cliente'] is Map) {
      clientData = Map<String, dynamic>.from(map['cliente']);
    } else if (map['cliente'] is String) {
      try {
        clientData = json.decode(map['cliente']);
      } catch (e) {
        clientData = {};
      }
    }

    // Helper function to convert int to bool
    bool toBool(dynamic value) {
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) return value.toLowerCase() == 'true' || value == '1';
      return false;
    }

    return Bill(
      id: map['_id'],
      codigo: map['codigo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      cliente: clientData,
      transporte: map['transporte'] ?? '',
      moneda: map['moneda'] is Map ? map['moneda'] : {},
      vendedor: map['vendedor'] is Map ? map['vendedor'] : {},
      condicionPago: map['condicionPago'] is Map ? map['condicionPago'] : {},
      fecEmis: map['fecEmis'] ?? '',
      fecVenc: map['fecVenc'] ?? '',
      fecReg: map['fecReg'] ?? '',
      anulado: toBool(map['anulado']),
      status: map['status'] ?? '',
      nControl: map['nControl'] ?? '',
      venTer: toBool(map['venTer']),
      tasa: map['tasa']?.toDouble() ?? 0.0,
      porcDescGlob: map['porcDescGlob']?.toDouble() ?? 0.0,
      montoDescGlob: map['montoDescGlob']?.toDouble() ?? 0.0,
      porcReca: map['porcReca']?.toDouble() ?? 0.0,
      montoReca: map['montoReca']?.toDouble() ?? 0.0,
      totalBruto: map['totalBruto']?.toDouble() ?? 0.0,
      montoImp: map['montoImp']?.toDouble() ?? 0.0,
      montoImp2: map['montoImp2']?.toDouble() ?? 0.0,
      montoImp3: map['montoImp3']?.toDouble() ?? 0.0,
      otros1: map['otros1']?.toDouble() ?? 0.0,
      otros2: map['otros2']?.toDouble() ?? 0.0,
      otros3: map['otros3']?.toDouble() ?? 0.0,
      totalNeto: map['totalNeto']?.toDouble() ?? 0.0,
      saldo: map['saldo']?.toDouble() ?? 0.0,
      dirEnt: map['dirEnt'] ?? '',
      comentario: map['comentario'] ?? '',
      contrib: toBool(map['contrib']),
      impresa: toBool(map['impresa']),
      isDeleted: toBool(map['isDeleted']),
      deletedAt: map['deletedAt'],
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      renglones: map['renglones'] is List ? map['renglones'] : [],
      datosAdicionales: map['datosAdicionales'] is List 
          ? List<Map<String, dynamic>>.from(map['datosAdicionales'])
          : [],
    );
  }

  // Convertir de un modelo Bill a un mapa de base de datos
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'cliente': json.encode(cliente),
      'transporte': transporte,
      'moneda': json.encode(moneda),
      'vendedor': json.encode(vendedor),
      'condicionPago': json.encode(condicionPago),
      'fecEmis': fecEmis,
      'fecVenc': fecVenc,
      'fecReg': fecReg,
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'renglones': json.encode(renglones),
      'datosAdicionales': json.encode(datosAdicionales),
    };
  }

  static const String createBillTable = '''
    CREATE TABLE bills (
      _id TEXT PRIMARY KEY,
      codigo TEXT,
      descripcion TEXT,
      cliente TEXT,
      transporte TEXT,
      moneda TEXT,
      vendedor TEXT,
      condicionPago TEXT,
      fecEmis TEXT,
      fecVenc TEXT,
      fecReg TEXT,
      anulado INTEGER DEFAULT 0,
      status TEXT,
      nControl TEXT,
      venTer INTEGER DEFAULT 0,
      tasa REAL DEFAULT 0,
      porcDescGlob REAL DEFAULT 0,
      montoDescGlob REAL DEFAULT 0,
      porcReca REAL DEFAULT 0,
      montoReca REAL DEFAULT 0,
      totalBruto REAL DEFAULT 0,
      montoImp REAL DEFAULT 0,
      montoImp2 REAL DEFAULT 0,
      montoImp3 REAL DEFAULT 0,
      otros1 REAL DEFAULT 0,
      otros2 REAL DEFAULT 0,
      otros3 REAL DEFAULT 0,
      totalNeto REAL DEFAULT 0,
      saldo REAL DEFAULT 0,
      dirEnt TEXT,
      comentario TEXT,
      contrib INTEGER DEFAULT 0,
      impresa INTEGER DEFAULT 0,
      isDeleted INTEGER DEFAULT 0,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT,
      renglones TEXT,
      datosAdicionales TEXT
    )
  ''';
}
