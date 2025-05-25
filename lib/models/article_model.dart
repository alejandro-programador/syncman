import 'dart:convert';

import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/models/color_model.dart';
import 'package:syncman_new/models/line_model.dart';
import 'package:syncman_new/models/origin_model.dart';
import 'package:syncman_new/models/subline_model.dart';
import 'package:syncman_new/models/ubication_model.dart';

class Articulo {
  final List<String> imagenes;
  final String id;
  final String codigo;
  final String fechaRegistro;
  final String descripcion;
  final String tipo;
  final bool anulado;
  final Linea linea;
  final SubLinea sublinea;
  final Category categoria;
  final ColorModel color;
  final Ubication ubicacion;
  final Origin procedencia;
  final String item;
  final String modelo;
  final String? referencia;
  final bool generico;
  final bool manejaSerial;
  final bool manejaLote;
  final bool manejaLoteConVencimiento;
  final String tipoImp;
  final String tipoImp2;
  final String garantia;
  final double volumen;
  final double peso;
  final int stockMinimo;
  final int stockMaximo;
  final int stockPedido;
  final int relacionUnidad;
  final bool precioOm;
  final String comentario;
  final String tipoCosto;
  final double montoComision;
  final List<DatoAdicional> datosAdicionales;
  final List<UnidadArticulo> unidades;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  final int? stock;
  final double? precio;
  final double? taxRate;

  Articulo({
    required this.imagenes,
    required this.id,
    required this.codigo,
    required this.fechaRegistro,
    required this.descripcion,
    required this.tipo,
    required this.anulado,
    required this.linea,
    required this.sublinea,
    required this.categoria,
    required this.color,
    required this.ubicacion,
    required this.procedencia,
    required this.item,
    required this.modelo,
    this.referencia,
    required this.generico,
    required this.manejaSerial,
    required this.manejaLote,
    required this.manejaLoteConVencimiento,
    required this.tipoImp,
    required this.tipoImp2,
    required this.garantia,
    required this.volumen,
    required this.peso,
    required this.stockMinimo,
    required this.stockMaximo,
    required this.stockPedido,
    required this.relacionUnidad,
    required this.precioOm,
    required this.comentario,
    required this.tipoCosto,
    required this.montoComision,
    required this.datosAdicionales,
    required this.unidades,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.stock,
    this.precio,
    this.taxRate,
  });

  static List<DatoAdicional> parseDatosAdicionales(dynamic value) {
    if (value == null) return [];
    if (value is String) {
      try {
        final List<dynamic> decoded = jsonDecode(value);
        return decoded.map((dato) => DatoAdicional.fromJson(dato)).toList();
      } catch (e) {
        print('Error parsing datosAdicionales: $e');
        return [];
      }
    }
    if (value is List) {
      return value.map((dato) => DatoAdicional.fromJson(dato)).toList();
    }
    return [];
  }

  static List<UnidadArticulo> parseUnidades(dynamic value) {
    if (value == null) return [];
    if (value is String) {
      try {
        final List<dynamic> decoded = jsonDecode(value);
        return decoded.map((u) => UnidadArticulo.fromJson(u)).toList();
      } catch (e) {
        print('Error parsing unidades: $e');
        return [];
      }
    }
    if (value is List) {
      return value.map((u) => UnidadArticulo.fromJson(u)).toList();
    }
    return [];
  }

  factory Articulo.fromJson(Map<String, dynamic> json) {
    return Articulo(
      imagenes: List<String>.from(json['imagenes'] ?? []),
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      fechaRegistro: json['fechaRegistro'] ?? '',
      descripcion: json['descripcion'] ?? '',
      tipo: json['tipo'] ?? '',
      anulado: json['anulado'] ?? false,
      linea: Linea.fromJson(json['linea'] ?? {}),
      sublinea: SubLinea.fromJson(json['sublinea'] ?? {}),
      categoria: Category.fromJson(json['categoria'] ?? {}),
      color: ColorModel.fromJson(json['color'] ?? {}),
      ubicacion: Ubication.fromJson(json['ubicacion'] ?? {}),
      procedencia: Origin.fromJson(json['procedencia'] ?? {}),
      item: json['item'] ?? '',
      modelo: json['modelo'] ?? '',
      referencia: json['referencia'],
      generico: json['generico'] ?? false,
      manejaSerial: json['manejaSerial'] ?? false,
      manejaLote: json['manejaLote'] ?? false,
      manejaLoteConVencimiento: json['manejaLoteConVencimiento'] ?? false,
      tipoImp: json['tipoImp'] ?? '',
      tipoImp2: json['tipoImp2'] ?? '',
      garantia: json['garantia'] ?? '',
      volumen: (json['volumen'] ?? 0).toDouble(),
      peso: (json['peso'] ?? 0).toDouble(),
      stockMinimo: json['stockMinimo'] ?? 0,
      stockMaximo: json['stockMaximo'] ?? 0,
      stockPedido: json['stockPedido'] ?? 0,
      relacionUnidad: json['relacionUnidad'] ?? 0,
      precioOm: json['precioOm'] ?? false,
      comentario: json['comentario'] ?? '',
      tipoCosto: json['tipoCosto'] ?? '',
      montoComision: (json['montoComision'] ?? 0).toDouble(),
      datosAdicionales: parseDatosAdicionales(json['datosAdicionales']),
      unidades: parseUnidades(json['unidades']),
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      stock: json['stock'],
      precio: json['precio']?.toDouble(),
      taxRate: json['taxRate']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'tipo': tipo,
      'anulado': anulado ? 1 : 0,
      'fechaRegistro': fechaRegistro,
      'linea': jsonEncode(linea.toMap()),
      'sublinea': jsonEncode(sublinea.toMap()),
      'categoria': jsonEncode(categoria.toMap()),
      'color': jsonEncode(color.toMap()),
      'ubicacion': jsonEncode(ubicacion.toMap()),
      'procedencia': jsonEncode(procedencia.toMap()),
      'modelo': modelo,
      'referencia': referencia,
      'garantia': garantia,
      'volumen': volumen,
      'peso': peso,
      'stockMinimo': stockMinimo,
      'stockMaximo': stockMaximo,
      'stockPedido': stockPedido,
      'precioOm': precioOm ? 1 : 0,
      'comentario': comentario,
      'tipoCosto': tipoCosto,
      'imagenes': jsonEncode(imagenes),
      'item': item,
      'generico': generico ? 1 : 0,
      'manejaSerial': manejaSerial ? 1 : 0,
      'manejaLote': manejaLote ? 1 : 0,
      'manejaLoteConVencimiento': manejaLoteConVencimiento ? 1 : 0,
      'tipoImp': tipoImp,
      'tipoImp2': tipoImp2,
      'relacionUnidad': relacionUnidad,
      'montoComision': montoComision,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'unidades': jsonEncode(unidades.map((u) => u.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'stock': stock,
      'precio': precio,
      'taxRate': taxRate,
    };
  }

  factory Articulo.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> parseJsonObject(dynamic value) {
      if (value == null) return {};
      if (value is String) {
        try {
          return jsonDecode(value);
        } catch (e) {
          print('Error parsing JSON object: $e');
          return {};
        }
      }
      if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
      return {};
    }

    List<String> parseStringList(dynamic value) {
      if (value == null) return [];
      if (value is String) {
        try {
          return List<String>.from(jsonDecode(value));
        } catch (e) {
          print('Error parsing string list: $e');
          return [];
        }
      }
      if (value is List) {
        return List<String>.from(value);
      }
      return [];
    }

    return Articulo(
      imagenes: parseStringList(map['imagenes']),
      id: map['_id'] ?? '',
      codigo: map['codigo'] ?? '',
      fechaRegistro: map['fechaRegistro'] ?? '',
      descripcion: map['descripcion'] ?? '',
      tipo: map['tipo'] ?? '',
      anulado: map['anulado'] is int ? map['anulado'] == 1 : map['anulado'] ?? false,
      linea: Linea.fromJson(parseJsonObject(map['linea'])),
      sublinea: SubLinea.fromJson(parseJsonObject(map['sublinea'])),
      categoria: Category.fromJson(parseJsonObject(map['categoria'])),
      color: ColorModel.fromJson(parseJsonObject(map['color'])),
      ubicacion: Ubication.fromJson(parseJsonObject(map['ubicacion'])),
      procedencia: Origin.fromJson(parseJsonObject(map['procedencia'])),
      item: map['item'] ?? '',
      modelo: map['modelo'] ?? '',
      referencia: map['referencia'],
      generico: map['generico'] is int ? map['generico'] == 1 : map['generico'] ?? false,
      manejaSerial: map['manejaSerial'] is int ? map['manejaSerial'] == 1 : map['manejaSerial'] ?? false,
      manejaLote: map['manejaLote'] is int ? map['manejaLote'] == 1 : map['manejaLote'] ?? false,
      manejaLoteConVencimiento: map['manejaLoteConVencimiento'] is int ? map['manejaLoteConVencimiento'] == 1 : map['manejaLoteConVencimiento'] ?? false,
      tipoImp: map['tipoImp'] ?? '',
      tipoImp2: map['tipoImp2'] ?? '',
      garantia: map['garantia'] ?? '',
      volumen: map['volumen']?.toDouble() ?? 0.0,
      peso: map['peso']?.toDouble() ?? 0.0,
      stockMinimo: map['stockMinimo'] ?? 0,
      stockMaximo: map['stockMaximo'] ?? 0,
      stockPedido: map['stockPedido'] ?? 0,
      relacionUnidad: map['relacionUnidad'] ?? 0,
      precioOm: map['precioOm'] is int ? map['precioOm'] == 1 : map['precioOm'] ?? false,
      comentario: map['comentario'] ?? '',
      tipoCosto: map['tipoCosto'] ?? '',
      montoComision: map['montoComision']?.toDouble() ?? 0.0,
      datosAdicionales: parseDatosAdicionales(map['datosAdicionales']),
      unidades: parseUnidades(map['unidades']),
      isDeleted: map['isDeleted'] is int ? map['isDeleted'] == 1 : map['isDeleted'] ?? false,
      deletedAt: map['deletedAt'],
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      stock: map['stock'],
      precio: map['precio']?.toDouble(),
      taxRate: map['taxRate']?.toDouble(),
    );
  }

  static const String createArticleTable = '''
    CREATE TABLE articles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      _id TEXT,
      codigo TEXT,
      descripcion TEXT,
      tipo TEXT,
      anulado INTEGER,
      fechaRegistro TEXT,
      linea TEXT,
      sublinea TEXT,
      categoria TEXT,
      color TEXT,
      ubicacion TEXT,
      procedencia TEXT,
      item TEXT,
      modelo TEXT,
      referencia TEXT,
      generico INTEGER,
      manejaSerial INTEGER,
      manejaLote INTEGER,
      manejaLoteConVencimiento INTEGER,
      tipoImp TEXT,
      tipoImp2 TEXT,
      garantia TEXT,
      volumen REAL,
      peso REAL,
      stockMinimo INTEGER,
      stockMaximo INTEGER,
      stockPedido INTEGER,
      relacionUnidad INTEGER,
      precioOm INTEGER,
      comentario TEXT,
      tipoCosto TEXT,
      montoComision REAL,
      datosAdicionales TEXT,
      unidades TEXT,
      imagenes TEXT,
      isDeleted INTEGER,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT,
      stock INTEGER,
      precio REAL,
      taxRate REAL
    )
  ''';
}

class DatoAdicional {
  final String nombre;
  final String? valor;
  final String id;

  DatoAdicional({
    required this.nombre,
    this.valor,
    required this.id,
  });

  factory DatoAdicional.fromJson(Map<String, dynamic> json) {
    return DatoAdicional(
      nombre: json['nombre'] ?? '',
      valor: json['valor'],
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'valor': valor,
      '_id': id,
    };
  }
}

class UnidadArticulo {
  final String id;
  final Unidad unidad;
  final double equivalencia;
  final bool inversa;
  final bool principalPrimaria;
  final bool principal;
  final List<DatoAdicional> datosAdicionales;
  final String createdAt;
  final String updatedAt;

  UnidadArticulo({
    required this.id,
    required this.unidad,
    required this.equivalencia,
    required this.inversa,
    required this.principalPrimaria,
    required this.principal,
    required this.datosAdicionales,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnidadArticulo.fromJson(Map<String, dynamic> json) {
    return UnidadArticulo(
      id: json['_id'] ?? '',
      unidad: Unidad.fromJson(json['unidad'] ?? {}),
      equivalencia: (json['equivalencia'] ?? 0).toDouble(),
      inversa: json['inversa'] ?? false,
      principalPrimaria: json['principalPrimaria'] ?? false,
      principal: json['principal'] ?? false,
      datosAdicionales: (json['datosAdicionales'] as List?)?.map((dato) => DatoAdicional.fromJson(dato)).toList() ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'unidad': unidad.toMap(),
      'equivalencia': equivalencia,
      'inversa': inversa ? 1 : 0,
      'principalPrimaria': principalPrimaria ? 1 : 0,
      'principal': principal ? 1 : 0,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class Unidad {
  final String id;
  final String codigo;
  final String descripcion;
  final List<DatoAdicional> datosAdicionales;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Unidad({
    required this.id,
    required this.codigo,
    required this.descripcion,
    required this.datosAdicionales,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unidad.fromJson(Map<String, dynamic> json) {
    return Unidad(
      id: json['_id'] ?? '',
      codigo: json['codigo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      datosAdicionales: (json['datosAdicionales'] as List?)?.map((dato) => DatoAdicional.fromJson(dato)).toList() ?? [],
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'codigo': codigo,
      'descripcion': descripcion,
      'datosAdicionales': jsonEncode(datosAdicionales.map((dato) => dato.toMap()).toList()),
      'isDeleted': isDeleted ? 1 : 0,
      'deletedAt': deletedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
