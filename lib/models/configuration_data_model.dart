class ConfigurationData {
  final String transporte;
  final String transporteCodigo;
  final String transporteDescripcion;
  final String ctaIngrEgr;
  final String ctaIngrEgrCodigo;
  final String ctaIngrEgrDescripcion;
  final String sucursal;
  final String sucursalCodigo;
  final String sucursalDescripcion;
  final bool usarTasa;
  final String almacen;
  final String almacenCodigo;
  final String almacenDescripcion;

  ConfigurationData({
    required this.transporte,
    required this.transporteCodigo,
    required this.transporteDescripcion,
    required this.ctaIngrEgr,
    required this.ctaIngrEgrCodigo,
    required this.ctaIngrEgrDescripcion,
    required this.sucursal,
    required this.sucursalCodigo,
    required this.sucursalDescripcion,
    required this.usarTasa,
    required this.almacen,
    required this.almacenCodigo,
    required this.almacenDescripcion,
  });

  factory ConfigurationData.fromJson(Map<String, dynamic> json) {
    return ConfigurationData(
      transporte: json['transporte'],
      transporteCodigo: json['transporteCodigo'],
      transporteDescripcion: json['transporteDescripcion'],
      ctaIngrEgr: json['ctaIngrEgr'],
      ctaIngrEgrCodigo: json['ctaIngrEgrCodigo'],
      ctaIngrEgrDescripcion: json['ctaIngrEgrDescripcion'],
      sucursal: json['sucursal'],
      sucursalCodigo: json['sucursalCodigo'],
      sucursalDescripcion: json['sucursalDescripcion'],
      usarTasa: json['usarTasa'] ?? false,
      almacen: json['almacen'],
      almacenCodigo: json['almacenCodigo'],
      almacenDescripcion: json['almacenDescripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transporte': transporte,
      'transporteCodigo': transporteCodigo,
      'transporteDescripcion': transporteDescripcion,
      'ctaIngrEgr': ctaIngrEgr,
      'ctaIngrEgrCodigo': ctaIngrEgrCodigo,
      'ctaIngrEgrDescripcion': ctaIngrEgrDescripcion,
      'sucursal': sucursal,
      'sucursalCodigo': sucursalCodigo,
      'sucursalDescripcion': sucursalDescripcion,
      'usarTasa': usarTasa,
      'almacen': almacen,
      'almacenCodigo': almacenCodigo,
      'almacenDescripcion': almacenDescripcion,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'transporte': transporte,
      'transporteCodigo': transporteCodigo,
      'transporteDescripcion': transporteDescripcion,
      'ctaIngrEgr': ctaIngrEgr,
      'ctaIngrEgrCodigo': ctaIngrEgrCodigo,
      'ctaIngrEgrDescripcion': ctaIngrEgrDescripcion,
      'sucursal': sucursal,
      'sucursalCodigo': sucursalCodigo,
      'sucursalDescripcion': sucursalDescripcion,
      'usarTasa': usarTasa ? 1 : 0, // SQLite no soporta booleanos directamente
      'almacen': almacen,
      'almacenCodigo': almacenCodigo,
      'almacenDescripcion': almacenDescripcion,
    };
  }
}
