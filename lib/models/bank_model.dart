class Bank {
  String id;
  String codigo;
  String descripcion;
  DateTime updatedAt;

  Bank(
      {required this.id, required this.codigo, required this.descripcion, required this.updatedAt});

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? '',
      codigo: map['codigo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : DateTime.now(),
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
