class DatoAdicional {
  final String id;
  final String nombre;
  final String? valor;

  DatoAdicional({
    required this.id,
    required this.nombre,
    this.valor,
  });

  factory DatoAdicional.fromJson(Map<String, dynamic> json) {
    return DatoAdicional(
      id: json['_id'],
      nombre: json['nombre'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'valor': valor,
    };
  }
}
