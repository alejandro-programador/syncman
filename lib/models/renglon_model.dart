class Renglon {
  final String id;
  final int rengNum;
  final String articulo;
  final String desArt;
  final String almacen;
  final double totalArt;
  final double stotalArt;
  final String unidad;
  final String unidadSecundaria;
  final String tipoPrecio;
  final double precVta;
  final double porcDesc;
  final double montoDesc;
  final String tipoImp;
  final double porcImp;
  final double porcImp2;
  final double porcImp3;
  final double montoImp;
  final double montoImp2;
  final double montoImp3;
  final double rengNeto;
  final double pendiente;
  final double totalDev;
  final double montoDev;
  final double otros;
  final String comentario;
  final bool loteAsignado;
  final double montoDescGlob;
  final double montoRecaGlob;
  final double otros1Glob;
  final double otros2Glob;
  final double otros3Glob;
  final double montoImpAfecGlob;
  final double montoImp2AfecGlob;
  final double montoImp3AfecGlob;
  final List<String> seriales; // Asumiendo que es una lista de strings vacía o con valores
  final DateTime createdAt;
  final DateTime updatedAt;

  Renglon({
    required this.id,
    required this.rengNum,
    required this.articulo,
    required this.desArt,
    required this.almacen,
    required this.totalArt,
    required this.stotalArt,
    required this.unidad,
    required this.unidadSecundaria,
    required this.tipoPrecio,
    required this.precVta,
    required this.porcDesc,
    required this.montoDesc,
    required this.tipoImp,
    required this.porcImp,
    required this.porcImp2,
    required this.porcImp3,
    required this.montoImp,
    required this.montoImp2,
    required this.montoImp3,
    required this.rengNeto,
    required this.pendiente,
    required this.totalDev,
    required this.montoDev,
    required this.otros,
    required this.comentario,
    required this.loteAsignado,
    required this.montoDescGlob,
    required this.montoRecaGlob,
    required this.otros1Glob,
    required this.otros2Glob,
    required this.otros3Glob,
    required this.montoImpAfecGlob,
    required this.montoImp2AfecGlob,
    required this.montoImp3AfecGlob,
    required this.seriales,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Renglon.fromJson(Map<String, dynamic> json) {
    return Renglon(
      id: json['_id'],
      rengNum: json['rengNum'],
      articulo: json['articulo'],
      desArt: json['desArt'],
      almacen: json['almacen'],
      totalArt: (json['totalArt'] ?? 0).toDouble(),
      stotalArt: (json['stotalArt'] ?? 0).toDouble(),
      unidad: json['unidad'],
      unidadSecundaria: json['unidadSecundaria'],
      tipoPrecio: json['tipoPrecio'],
      precVta: (json['precVta'] ?? 0).toDouble(),
      porcDesc: (json['porcDesc'] ?? 0).toDouble(),
      montoDesc: (json['montoDesc'] ?? 0).toDouble(),
      tipoImp: json['tipoImp'],
      porcImp: (json['porcImp'] ?? 0).toDouble(),
      porcImp2: (json['porcImp2'] ?? 0).toDouble(),
      porcImp3: (json['porcImp3'] ?? 0).toDouble(),
      montoImp: (json['montoImp'] ?? 0).toDouble(),
      montoImp2: (json['montoImp2'] ?? 0).toDouble(),
      montoImp3: (json['montoImp3'] ?? 0).toDouble(),
      rengNeto: (json['rengNeto'] ?? 0).toDouble(),
      pendiente: (json['pendiente'] ?? 0).toDouble(),
      totalDev: (json['totalDev'] ?? 0).toDouble(),
      montoDev: (json['montoDev'] ?? 0).toDouble(),
      otros: (json['otros'] ?? 0).toDouble(),
      comentario: json['comentario'] ?? '',
      loteAsignado: json['loteAsignado'] ?? false,
      montoDescGlob: (json['montoDescGlob'] ?? 0).toDouble(),
      montoRecaGlob: (json['montoRecaGlob'] ?? 0).toDouble(),
      otros1Glob: (json['otros1Glob'] ?? 0).toDouble(),
      otros2Glob: (json['otros2Glob'] ?? 0).toDouble(),
      otros3Glob: (json['otros3Glob'] ?? 0).toDouble(),
      montoImpAfecGlob: (json['montoImpAfecGlob'] ?? 0).toDouble(),
      montoImp2AfecGlob: (json['montoImp2AfecGlob'] ?? 0).toDouble(),
      montoImp3AfecGlob: (json['montoImp3AfecGlob'] ?? 0).toDouble(),
      seriales: List<String>.from(json['seriales'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'rengNum': rengNum,
      'articulo': articulo,
      'desArt': desArt,
      'almacen': almacen,
      'totalArt': totalArt,
      'stotalArt': stotalArt,
      'unidad': unidad,
      'unidadSecundaria': unidadSecundaria,
      'tipoPrecio': tipoPrecio,
      'precVta': precVta,
      'porcDesc': porcDesc,
      'montoDesc': montoDesc,
      'tipoImp': tipoImp,
      'porcImp': porcImp,
      'porcImp2': porcImp2,
      'porcImp3': porcImp3,
      'montoImp': montoImp,
      'montoImp2': montoImp2,
      'montoImp3': montoImp3,
      'rengNeto': rengNeto,
      'pendiente': pendiente,
      'totalDev': totalDev,
      'montoDev': montoDev,
      'otros': otros,
      'comentario': comentario,
      'loteAsignado': loteAsignado ? 1 : 0,
      'montoDescGlob': montoDescGlob,
      'montoRecaGlob': montoRecaGlob,
      'otros1Glob': otros1Glob,
      'otros2Glob': otros2Glob,
      'otros3Glob': otros3Glob,
      'montoImpAfecGlob': montoImpAfecGlob,
      'montoImp2AfecGlob': montoImp2AfecGlob,
      'montoImp3AfecGlob': montoImp3AfecGlob,
      'seriales': seriales.join(','), // Para guardar como string si se usa SQLite
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
