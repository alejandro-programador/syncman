class Dashboard {
  double? montoVencido;
  double? montoNoVencido;
  double? montoAdeudado;
  int? pedidosCreados;
  int? pedidosParcialmente;
  int? pedidosProcesados;
  int? clientesDeudores;
  int? clientesSolventes;
  int? clientesConPedidosHoy;
  int? clientesSinPedidosHoy;
  double? proyeccionTotalVendido;
  double? proyeccionTotalVendidoAcum;
  int? proyeccionCantidadProductos;
  int? proyeccionCantidadProductosAcum;
  int? proyeccionCantidadClientes;
  int? proyeccionCantidadClientesAcum;
  DateTime? createdAt;
  DateTime? updatedAt;

  Dashboard({
    this.montoVencido,
    this.montoNoVencido,
    this.montoAdeudado,
    this.pedidosCreados,
    this.pedidosParcialmente,
    this.pedidosProcesados,
    this.clientesDeudores,
    this.clientesSolventes,
    this.clientesConPedidosHoy,
    this.clientesSinPedidosHoy,
    this.proyeccionTotalVendido,
    this.proyeccionTotalVendidoAcum,
    this.proyeccionCantidadProductos,
    this.proyeccionCantidadProductosAcum,
    this.proyeccionCantidadClientes,
    this.proyeccionCantidadClientesAcum,
    this.createdAt,
    this.updatedAt,
  });

  // Dashboard vacío para cuando no se encuentre un dashboard
  static final emptyDashboard = Dashboard(
    montoVencido: 0.0,
    montoNoVencido: 0.0,
    montoAdeudado: 0.20,
    pedidosCreados: 0,
    pedidosParcialmente: 0,
    pedidosProcesados: 0,
    clientesDeudores: 0,
    clientesSolventes: 0,
    clientesConPedidosHoy: 0,
    clientesSinPedidosHoy: 0,
    proyeccionTotalVendido: 0.0,
    proyeccionTotalVendidoAcum: 0.0,
    proyeccionCantidadProductos: 0,
    proyeccionCantidadProductosAcum: 0,
    proyeccionCantidadClientes: 0,
    proyeccionCantidadClientesAcum: 0,
  );

  // Convertir un mapa (desde la BD) a un objeto Dashboard
  factory Dashboard.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is num) return value.toInt();
      if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return Dashboard(
      montoVencido: parseDouble(map['montoVencido']),
      montoNoVencido: parseDouble(map['montoNoVencido']),
      montoAdeudado: parseDouble(map['montoAdeudado']),
      pedidosCreados: parseInt(map['pedidosCreados']),
      pedidosParcialmente: parseInt(map['pedidosParcialmente']),
      pedidosProcesados: parseInt(map['pedidosProcesados']),
      clientesDeudores: parseInt(map['clientesDeudores']),
      clientesSolventes: parseInt(map['clientesSolventes']),
      clientesConPedidosHoy: parseInt(map['clientesConPedidosHoy']),
      clientesSinPedidosHoy: parseInt(map['clientesSinPedidosHoy']),
      proyeccionTotalVendido: parseDouble(map['proyeccionTotalVendido']),
      proyeccionTotalVendidoAcum: parseDouble(map['proyeccionTotalVendidoAcum']),
      proyeccionCantidadProductos: parseInt(map['proyeccionCantidadProductos']),
      proyeccionCantidadProductosAcum: parseInt(map['proyeccionCantidadProductosAcum']),
      proyeccionCantidadClientes: parseInt(map['proyeccionCantidadClientes']),
      proyeccionCantidadClientesAcum: parseInt(map['proyeccionCantidadClientesAcum']),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convertir un objeto Dashboard a un mapa (para la BD)
  Map<String, dynamic> toMap() {
    return {
      'montoVencido': montoVencido,
      'montoNoVencido': montoNoVencido,
      'montoAdeudado': montoAdeudado,
      'pedidosCreados': pedidosCreados,
      'pedidosParcialmente': pedidosParcialmente,
      'pedidosProcesados': pedidosProcesados,
      'clientesDeudores': clientesDeudores,
      'clientesSolventes': clientesSolventes,
      'clientesConPedidosHoy': clientesConPedidosHoy,
      'clientesSinPedidosHoy': clientesSinPedidosHoy,
      'proyeccionTotalVendido': proyeccionTotalVendido,
      'proyeccionTotalVendidoAcum': proyeccionTotalVendidoAcum,
      'proyeccionCantidadProductos': proyeccionCantidadProductos,
      'proyeccionCantidadProductosAcum': proyeccionCantidadProductosAcum,
      'proyeccionCantidadClientes': proyeccionCantidadClientes,
      'proyeccionCantidadClientesAcum': proyeccionCantidadClientesAcum,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static const String createDashboardTable = '''
    CREATE TABLE dashboard (
      montoVencido REAL DEFAULT 0,
      montoNoVencido REAL DEFAULT 0,
      montoAdeudado REAL DEFAULT 0,
      pedidosCreados INTEGER DEFAULT 0,
      pedidosParcialmente INTEGER DEFAULT 0,
      pedidosProcesados INTEGER DEFAULT 0,
      clientesDeudores INTEGER DEFAULT 0,
      clientesSolventes INTEGER DEFAULT 0,
      clientesConPedidosHoy INTEGER DEFAULT 0,
      clientesSinPedidosHoy INTEGER DEFAULT 0,
      proyeccionTotalVendido REAL DEFAULT 0,
      proyeccionTotalVendidoAcum REAL DEFAULT 0,
      proyeccionCantidadProductos INTEGER DEFAULT 0,
      proyeccionCantidadProductosAcum INTEGER DEFAULT 0,
      proyeccionCantidadClientes INTEGER DEFAULT 0,
      proyeccionCantidadClientesAcum INTEGER DEFAULT 0,
      createdAt TEXT,
      updatedAt TEXT
    );
  ''';
} 