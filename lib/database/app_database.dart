import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/models/tipo_precio_model.dart';
import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/models/zone_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  // Regenerate DB
  Future<void> regenerateDB() async {
    await deleteCurrentDatabase();
    await getDatabase();
    debugPrint('DB Regenerada');
  }

  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        [tableName]);

    return result.isNotEmpty;
  }

  // delete local DB
  Future<void> deleteCurrentDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    // Elimina el archivo de la base de datos
    await deleteDatabase(path);
  }

  // Create local DB
  Future _createDB(Database db, int version) async {
    print('\n=== Initializing Database ===');
    
    // Client table
    await db.execute(Client.createClientsTable);
    print('Client table created');

    // Seller table
    await db.execute(Seller.createSellerTable);
    print('Seller table created');

    // Valija table
    await db.execute(Valija.createValijaTable);
    print('Valija table created');

    // Payment table
    await db.execute(Payment.createPaymentTable);
    print('Payment table created');

    // Bill table
    await db.execute(Bill.createBillTable);
    print('Bill table created');

    // Article table
    await db.execute(Articulo.createArticleTable);
    print('Article table created');

    // Category table
    await db.execute(Category.createCategoryTable);
    print('Category table created');

    // Price table
    await db.execute(Price.createPriceTable);
    print('Price table created');

    // Transport table
    await db.execute(Transport.createTransportTable);
    print('Transport table created');

    // Currency table
    await db.execute(Currency.createCurrencyTable);
    print('Currency table created');

    // Payment Condition table
    await db.execute(PaymentCondition.createPaymentConditionTable);
    print('Payment Condition table created');

    // CTA INGR EGR table
    await db.execute(CtaIngrEgr.createCtaIngrEgrTable);
    print('CTA INGR EGR table created');

    // Tax table
    await db.execute(Tax.createTaxTable);
    print('Tax table created');

    // Zone table
    await db.execute(Area.createZoneTable);
    print('Zone table created');

    // Collect Payment Method table
    await db.execute(CollectPaymentMethod.createPaymentMethodTable);
    print('Collect Payment Method table created');

    // Tipo Precio table
    await db.execute(TipoPrecio.createTipoPrecioTable);
    print('Tipo Precio table created');

    // Dashboard table
    await db.execute(Dashboard.createDashboardTable);
    print('Dashboard table created successfully');

    // Return Record table (devolucion)
    await db.execute(ReturnRecord.createReturnRecordTable);
    print('Return Record table created');

    // Collect table
    await db.execute(Collect.createCollectTable);
    print('Collect table created');

    // Orders table
    await db.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      _id TEXT,
      codigo TEXT,
      descripcion TEXT,
      cliente TEXT,
      transporte TEXT,
      moneda TEXT,
      vendedor TEXT,
      condicionPago TEXT,
      fecEmis TEXT,
      fecVenc TEXT,
      fecReg TEXT,
      anulado INTEGER,
      status TEXT,
      nControl TEXT,
      venTer INTEGER,
      tasa REAL,
      porcDescGlob REAL,
      montoDescGlob REAL,
      porcReca REAL,
      montoReca REAL,
      totalBruto REAL,
      montoImp REAL,
      montoImp2 REAL,
      montoImp3 REAL,
      otros1 REAL,
      otros2 REAL,
      otros3 REAL,
      totalNeto REAL,
      saldo REAL,
      dirEnt TEXT,
      comentario TEXT,
      contrib INTEGER,
      impresa INTEGER,
      isDeleted INTEGER,
      deletedAt TEXT,
      createdAt TEXT,
      updatedAt TEXT,
      datosAdicionales TEXT,
      renglones TEXT
    )
  ''');

    // Create units
    await db.execute('''
      CREATE TABLE units (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT,
        codigo TEXT,
        descripcion TEXT,
        isDeleted INTEGER,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        datosAdicionales TEXT
      )
    ''');

    // Create stock
    await db.execute('''
      CREATE TABLE stock_almacenes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT,
        almacen TEXT,
        articulo TEXT,
        tipo TEXT,
        stock INTEGER,
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Sublinea table
    await db.execute('''
      CREATE TABLE sublinea (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT UNIQUE,
        linea TEXT,
        codigo TEXT,
        descripcion TEXT,
        iSublDes TEXT,
        datosAdicionales TEXT, -- Se almacena como JSON
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Transport table
    // await db.execute('''
    //   CREATE TABLE transportes (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     _id TEXT UNIQUE,
    //     codigo TEXT,
    //     descripcion TEXT,
    //     respTra TEXT,
    //     datosAdicionales TEXT, -- Se almacena como JSON
    //     isDeleted INTEGER DEFAULT 0,
    //     deletedAt TEXT,
    //     createdAt TEXT,
    //     updatedAt TEXT
    //   )
    // ''');

    // Currency table
    // await db.execute('''
    //   CREATE TABLE monedas (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     _id TEXT UNIQUE,
    //     codigo TEXT,
    //     nombre TEXT,
    //     cambio REAL,
    //     relacion INTEGER,
    //     datosAdicionales TEXT, -- Se almacena como JSON
    //     isDeleted INTEGER DEFAULT 0,
    //     deletedAt TEXT,
    //     createdAt TEXT,
    //     updatedAt TEXT
    //   )
    // ''');

    // Payment Condition table
    // await db.execute('''
    // CREATE TABLE condicion_pagos (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     _id TEXT UNIQUE,
    //     codigo TEXT,
    //     descripcion TEXT,
    //     diasCred INTEGER,
    //     datosAdicionales TEXT, -- Se almacena como JSON
    //     isDeleted INTEGER DEFAULT 0,
    //     deletedAt TEXT,
    //     createdAt TEXT,
    //     updatedAt TEXT
    // )
    // ''');

    // CTA INGR EGR table
    // await db.execute('''
    // CREATE TABLE cta_ingr_egr (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   _id TEXT UNIQUE,
    //   codigo TEXT,
    //   descripcion TEXT,
    //   datosAdicionales TEXT, -- Se almacenará en formato JSON
    //   isDeleted INTEGER DEFAULT 0,
    //   deletedAt TEXT,
    //   createdAt TEXT,
    //   updatedAt TEXT
    // )
    // ''');

    // Configuration table
    await db.execute('''
    CREATE TABLE config_app (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        _id TEXT,
        nombre TEXT,
        configuracion TEXT, -- Guardas todo el objeto como JSON string
        isDeleted INTEGER DEFAULT 0,
        deletedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
    )
    ''');

    // Tax table
    // await db.execute('''
    // CREATE TABLE impuestos (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     _id TEXT,
    //     fecha TEXT,
    //     rengNum INTEGER,
    //     tipoImpuesto TEXT,
    //     ventas INTEGER DEFAULT 0,
    //     compras INTEGER DEFAULT 0,
    //     consumoSuntuario INTEGER DEFAULT 0,
    //     porcTasa REAL,
    //     porcSuntuario REAL,
    //     isDeleted INTEGER DEFAULT 0,
    //     deletedAt TEXT
    // )
    // ''');

    await db.execute('''
      CREATE TABLE banks(
        id TEXT PRIMARY KEY,
        codigo TEXT,
        descripcion TEXT,
        updatedAt TEXT
      )
    ''');

    // await db.execute('''
    //   CREATE TABLE areas(
    //     id TEXT PRIMARY KEY,
    //     codigo TEXT,
    //     descripcion TEXT,
    //     updatedAt TEXT
    //   )
    // ''');
  }

  // Get Database
  Future<Database> getDatabase() async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    print('=== Database Path ===');
    print('Path: $path');
    print('===================');

    return await openDatabase(
      path,
      version: 3, // Increment version number
      onCreate: _createDB,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 3) {
          // Drop the old articles table
          await db.execute('DROP TABLE IF EXISTS articles');

          // Create the new articles table with all columns
          await db.execute('''
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
              unidadNameList TEXT,
              prices TEXT,
              stock INTEGER,
              precio REAL,
              taxRate REAL
            )
          ''');
        }
      },
    );
  }

  Future<int> insertClient(Client client) async {
    final db = await instance.database;
    return await db.insert('clients', client.toMap());
  }

  Future<List<Client>> getAllClients() async {
    final db = await instance.database;
    final result = await db.query('clients');
    return result.map((map) => Client.fromMap(map)).toList();
  }

  Future<void> clearClients() async {
    final db = await getDatabase();
    await db.delete('clients');
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await AppDatabase.instance.getDatabase();
    final List<Map<String, dynamic>> orders = await db.query('orders');

    return orders.map((order) {
      return {
        ...order,
        'datosAdicionales': order['datosAdicionales'] != null
            ? jsonDecode(order['datosAdicionales'])
            : [],
        'renglones':
            order['renglones'] != null ? jsonDecode(order['renglones']) : [],
      };
    }).toList();
  }

  // GENERAL FUNCTIONS
  Future<List<Map<String, dynamic>>> dbQuery(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await instance.database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> dbUpdate(String table, Map<String, dynamic> values,
      {String? where, List<dynamic>? whereArgs}) async {
    final db = await instance.database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> dbInsert(String tableName, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert(tableName, data);
  }

  Future<List<Map<String, dynamic>>> dbGetAll(String tableName) async {
    final db = await instance.database;
    return await db.query(tableName);
  }

  Future<Map<String, dynamic>> getConfig() async {
    final db = await instance.database;
    final result = await db.query('config_app');

    if (result.isEmpty) return {};

    final original = result.first;

    // Crear una copia modificable
    final config = Map<String, dynamic>.from(original);

    config['configuracion'] = jsonDecode(config['configuracion'] as String);

    return config;
  }

  Future<int> dbInsertBill(Bill bill) async {
    final db = await instance.database;
    return await db.insert(
      'bills',
      bill.toMap(),
      conflictAlgorithm: ConflictAlgorithm
          .replace, // Esto asegura que si hay un conflicto, se reemplace el registro.
    );
  }

  Future<List<Bill>> dbGetAllBills() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('bills');

    return List.generate(maps.length, (i) {
      return Bill.fromMap(maps[i]);
    });
  }

  Future<int> dbInsertModel<T>(String tableName, T model) async {
    final db = await instance.database;
    return await db.insert(
      tableName,
      (model as dynamic).toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Reemplaza en caso de conflicto
    );
  }

  Future<List<T>> dbGetAllModels<T>(
      String tableName, T Function(Map<String, dynamic>) fromMap) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    });
  }

  Future<void> dbClearTable(String tableName) async {
    final db = await instance.database;
    await db.delete(tableName);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
