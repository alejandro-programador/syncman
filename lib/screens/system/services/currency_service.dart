import 'package:flutter/material.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/local_currency_read_repository.dart';
import 'package:syncman_new/services/sync/sync_manager.dart';

class CurrencyService {
  final LocalCurrencyReadRepository _currencyRepository;
  List<Currency> _currencies = [];
  Currency? _selectedCurrency;

  CurrencyService(this._currencyRepository);

  List<Currency> get currencies => _currencies;
  Currency? get selectedCurrency => _selectedCurrency;

  Future<void> syncAndLoadCurrencies() async {
    try {
      print('=== Starting Currency Sync ===');
      
      final db = await AppDatabase.instance.database;
      final tableExists = await AppDatabase.instance.tableExists('monedas');
      
      if (!tableExists) {
        print('Currency table does not exist, creating it...');
        await db.execute(Currency.createCurrencyTable);
        print('Currency table created successfully');
      }

      final syncManager = SyncManager();
      await syncManager.init();
      
      print('Syncing currencies...');
      await syncManager.sync('currency');
      print('Currency sync completed');
      
      await _loadCurrencies();
    } catch (e, stackTrace) {
      print('Error in currency sync: $e');
      print('Stack trace: $stackTrace');
      
      try {
        print('Attempting to load currencies from local database...');
        await _loadCurrencies();
      } catch (loadError) {
        print('Error loading currencies from local database: $loadError');
        rethrow;
      }
    }
  }

  Future<void> _loadCurrencies() async {
    try {
      print('=== Loading Currencies ===');
      final currencies = await _currencyRepository.query();
      print('Number of currencies found: ${currencies.length}');
      
      _currencies = currencies;
      if (currencies.isNotEmpty) {
        _selectedCurrency = currencies.first;
        print('Selected currency: ${_selectedCurrency?.nombre}');
      } else {
        print('No currencies found in database');
      }
    } catch (e, stackTrace) {
      print('Error loading currencies: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  void setSelectedCurrency(Currency currency) {
    _selectedCurrency = currency;
  }
} 