import 'package:syncman_new/models/additional_model.dart';

class Seller {
  final String id;
  final String codigo;
  final String descripcion;
  final String tipo;
  final String zona;
  final String cedula;
  final String direc1;
  final String telefonos;
  final DateTime? fechaReg;
  final bool inactivo;
  final double comision;
  final String comentario;
  final bool funCob;
  final bool funVen;
  final double comisionv;
  final String login;
  final String password;
  final String email;
  final String pswM;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double saldoCXC;
  final double saldoDeudor;
  final double saldoDeudorTotal;

  Seller({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.tipo,
    required this.zona,
    required this.cedula,
    required this.direc1,
    required this.telefonos,
    this.fechaReg,
    required this.inactivo,
    required this.comision,
    required this.comentario,
    required this.funCob,
    required this.funVen,
    required this.comisionv,
    required this.login,
    required this.password,
    required this.email,
    required this.pswM,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.saldoCXC,
    required this.saldoDeudor,
    required this.saldoDeudorTotal,
  });

  factory Seller.fromMap(Map<String, dynamic> map) {
    var additionals = (map['datosAdicionales'] as List?)
        ?.map((datoJson) => DatoAdicional.fromJson(datoJson))
        .toList() ?? [];

    return Seller(
      id: map['_id'] ?? map['id'] ?? '',
      codigo: map['codigo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      tipo: map['tipo'] ?? '',
      zona: map['zona'] ?? '',
      cedula: map['cedula'] ?? '',
      direc1: map['direc1'] ?? '',
      telefonos: map['telefonos'] ?? '',
      fechaReg: map['fechaReg'] != null ? DateTime.tryParse(map['fechaReg']) : null,
      inactivo: map['inactivo'] == 1 || map['inactivo'] == true || map['inactivo'] == '1',
      comision: (map['comision'] ?? 0).toDouble(),
      comentario: map['comentario'] ?? '',
      funCob: map['funCob'] == 1 || map['funCob'] == true || map['funCob'] == '1',
      funVen: map['funVen'] == 1 || map['funVen'] == true || map['funVen'] == '1',
      comisionv: (map['comisionv'] ?? 0).toDouble(),
      login: map['login'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
      pswM: map['pswM'] ?? '',
      datosAdicionales: additionals,
      isDeleted: map['isDeleted'] == 1 || map['isDeleted'] == true || map['isDeleted'] == '1',
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
      saldoCXC: (map['saldoCXC'] ?? 0).toDouble(),
      saldoDeudor: (map['saldo_deudor'] ?? 0).toDouble(),
      saldoDeudorTotal: (map['saldo_deudor_total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'tipo': tipo,
      'zona': zona,
      'cedula': cedula,
      'direc1': direc1,
      'telefonos': telefonos,
      'fechaReg': fechaReg?.toIso8601String(),
      'inactivo': inactivo ? 1 : 0,
      'comision': comision,
      'comentario': comentario,
      'funCob': funCob ? 1 : 0,
      'funVen': funVen ? 1 : 0,
      'comisionv': comisionv,
      'login': login,
      'password': password,
      'email': email,
      'pswM': pswM,
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'saldoCXC': saldoCXC,
      'saldo_deudor': saldoDeudor,
      'saldo_deudor_total': saldoDeudorTotal,
    };
  }

  static const String createSellerTable = '''
    CREATE TABLE sellers (
    id TEXT PRIMARY KEY,
    codigo TEXT,
    descripcion TEXT,
    tipo TEXT,
    zona TEXT,
    cedula TEXT,
    direc1 TEXT,
    telefonos TEXT,
    fechaReg TEXT,
    inactivo INTEGER DEFAULT 0,
    comision REAL,
    comentario TEXT,
    funCob INTEGER DEFAULT 0,
    funVen INTEGER DEFAULT 0,
    comisionv REAL,
    login TEXT,
    password TEXT,
    email TEXT,
    saldo_deudor REAL DEFAULT 0,
    saldo_deudor_total REAL DEFAULT 0,
    saldoCXC REAL DEFAULT 0,
    pswM TEXT,
    datosAdicionales TEXT,
    isDeleted INTEGER DEFAULT 0,
    deletedAt TEXT,
    createdAt TEXT,
    updatedAt TEXT
  );
  ''';
}
