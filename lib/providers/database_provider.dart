import 'package:flutter/material.dart';
import 'package:syncman_new/database/app_database.dart';

class DatabaseProvider with ChangeNotifier {
  final AppDatabase _database;

  DatabaseProvider(this._database);

  Future<void> regenerateDB() async {
    await _database.regenerateDB();
  }

  Future<void> clearTable() async {
    await _database.dbClearTable('clients');
    await _database.dbClearTable('sellers');
    await _database.dbClearTable('bills');
    await _database.dbClearTable('articles');
    await _database.dbClearTable('orders');
    await _database.dbClearTable('categories');
    await _database.dbClearTable('article_prices');
    await _database.dbClearTable('units');
    await _database.dbClearTable('stock_almacenes');
    await _database.dbClearTable('tipo_precios');
    await _database.dbClearTable('sublinea');
    await _database.dbClearTable('transportes');
    await _database.dbClearTable('monedas');
    await _database.dbClearTable('condicion_pagos');
    await _database.dbClearTable('cta_ingr_egr');
  }
}
