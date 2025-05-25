class ReturnProduct {
  final int rengNum;
  final String coArt;
  final String artDes;
  final double porcImp;
  final double montoImp;
  final double rengNeto;
  final double precVta;
  final int totalArt;
  final int cantNew;
  final bool check;
  final String id;

  ReturnProduct({
    required this.rengNum,
    required this.coArt,
    required this.artDes,
    required this.porcImp,
    required this.montoImp,
    required this.rengNeto,
    required this.precVta,
    required this.totalArt,
    required this.cantNew,
    required this.check,
    required this.id,
  });

  factory ReturnProduct.fromJson(Map<String, dynamic> json) {
    return ReturnProduct(
      rengNum: json['reng_num'] ?? 0,
      coArt: json['co_art'] ?? '',
      artDes: json['art_des'] ?? '',
      porcImp: (json['porc_imp'] ?? 0).toDouble(),
      montoImp: (json['monto_imp'] ?? 0).toDouble(),
      rengNeto: (json['reng_neto'] ?? 0).toDouble(),
      precVta: (json['prec_vta'] ?? 0).toDouble(),
      totalArt: json['total_art'] ?? 0,
      cantNew: json['cantNew'] ?? 0,
      check: json['check'] ?? false,
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reng_num': rengNum,
      'co_art': coArt,
      'art_des': artDes,
      'porc_imp': porcImp,
      'monto_imp': montoImp,
      'reng_neto': rengNeto,
      'prec_vta': precVta,
      'total_art': totalArt,
      'cantNew': cantNew,
      'check': check,
      '_id': id,
    };
  }
} 