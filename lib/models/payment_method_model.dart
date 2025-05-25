class PaymentMethod {
  final String cuenta;
  final String? titular;
  final String? rif;
  final String? referencia;
  final String? referenciaOld;
  final DateTime fecha;
  final double base;
  final double iva;
  final double total;
  final String id;

  PaymentMethod({
    required this.cuenta,
    this.titular,
    this.rif,
    this.referencia,
    this.referenciaOld,
    required this.fecha,
    required this.base,
    required this.iva,
    required this.total,
    required this.id,
  });

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      cuenta: map['cuenta'] ?? '',
      titular: map['titular'],
      rif: map['rif'],
      referencia: map['referencia'],
      referenciaOld: map['referenciaOld'],
      fecha: DateTime.parse(map['fecha']),
      base: (map['base'] ?? 0).toDouble(),
      iva: (map['iva'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      id: map['_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cuenta': cuenta,
      'titular': titular,
      'rif': rif,
      'referencia': referencia,
      'referenciaOld': referenciaOld,
      'fecha': fecha.toIso8601String(),
      'base': base,
      'iva': iva,
      'total': total,
      '_id': id,
    };
  }
} 