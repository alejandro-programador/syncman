class Client {
  String? id;
  String? codigo;
  String? descripcion;
  String? fechaReg;
  String? montCre;
  String? quantity;
  int? recent;
  String? date;
  double? saldo_deudor;
  double? saldo_deudor_total;
  double? saldoCXC;
  double? ultimoPedido;
  int? contrib;
  DateTime? updatedAt;

  Client({
    this.id,
    this.codigo,
    this.descripcion,
    this.fechaReg,
    this.montCre,
    this.quantity,
    this.recent,
    this.date,
    this.saldo_deudor,
    this.saldo_deudor_total,
    this.saldoCXC,
    this.ultimoPedido,
    this.contrib,
    this.updatedAt,
  });

  // Cliente vacío para cuando no se encuentre un cliente
  static final emptyClient = Client(
    id: '0',
    codigo: 'W-1467864',
    descripcion: 'Centro Gastronómico Mister Chef C.A.',
    fechaReg: 'Última compra hace un mes',
    montCre: '0',
    quantity: '0',
    recent: 0,
    date: 'Hace dos días',
    saldo_deudor: 0.0,
    saldo_deudor_total: 0.0,
    saldoCXC: 0.0,
    ultimoPedido: 0.0,
    contrib: 0,
  );

  // Convertir un mapa (desde la BD) a un objeto Client
  factory Client.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0; // Si no se puede convertir, devuelve 0.0
      }
      return 0.0;
    }

    return Client(
      id: map['id'],
      codigo: map['codigo'] ?? "W-1467864",
      descripcion: map['descripcion'] ?? "Centro Gastronómico Mister Chef C.A.",
      fechaReg: map['fechaReg'] ?? 'Última compra hace un mes',
      montCre: map['montCre']?.toString() ?? "0",
      quantity: map['quantity']?.toString() ?? "0",
      recent: (map['recent'] == true) ? 1 : 0,
      date: map['date'] ?? "Hace dos días",
      saldo_deudor: parseDouble(map['saldo_deudor']),
      saldo_deudor_total: parseDouble(map['saldo_deudor_total']),
      saldoCXC: parseDouble(map['saldoCXC']),
      ultimoPedido: parseDouble(map['ultimoPedido']),
      contrib: (map['contrib'] == true) ? 1 : 0,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convertir un objeto Client a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'fechaReg': fechaReg,
      'montCre': montCre,
      'quantity': quantity,
      'recent': recent,
      'date': date,
      'saldo_deudor': saldo_deudor,
      'saldo_deudor_total': saldo_deudor_total,
      'saldoCXC': saldoCXC,
      'ultimoPedido': ultimoPedido,
      'contrib': contrib,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createClientsTable = '''
    CREATE TABLE clients (      
      id TEXT,
      codigo TEXT,
      descripcion TEXT,
      fechaReg TEXT,
      montCre TEXT,
      quantity TEXT,
      recent INTEGER DEFAULT 0,
      date TEXT,
      saldo_deudor REAL DEFAULT 0,
      saldo_deudor_total REAL DEFAULT 0,
      saldoCXC REAL DEFAULT 0,
      ultimoPedido REAL DEFAULT 0,
      contrib INTEGER DEFAULT 0,
      updatedAt TEXT DEFAULT CURRENT_TIMESTAMP
    );
  ''';
}
