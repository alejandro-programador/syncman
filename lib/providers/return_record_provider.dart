import 'package:flutter/material.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/services/sync/return_record_service.dart';

class ReturnRecordProvider extends ChangeNotifier {
  final ReturnRecordService _returnRecordService;
  List<ReturnRecord> _returnRecords = [];
  ReturnRecord? _currentReturnRecord;
  bool _isLoading = false;

  ReturnRecordProvider({required ReturnRecordService returnRecordService})
      : _returnRecordService = returnRecordService;

  List<ReturnRecord> get returnRecords => _returnRecords;
  ReturnRecord? get currentReturnRecord => _currentReturnRecord;
  bool get isLoading => _isLoading;

  Future<void> loadReturnRecords() async {
    try {
      _isLoading = true;
      notifyListeners();

      _returnRecords = await _returnRecordService.query();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<ReturnRecord?> getReturnRecordById(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentReturnRecord = await _returnRecordService.getById(id);
      
      _isLoading = false;
      notifyListeners();
      return _currentReturnRecord;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<ReturnRecord?> getReturnRecordByCodigo(String codigo) async {
    try {
      _isLoading = true;
      notifyListeners();

      _currentReturnRecord = await _returnRecordService.getByCodigo(codigo);
      
      _isLoading = false;
      notifyListeners();
      return _currentReturnRecord;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> createReturnRecord(ReturnRecord record) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _returnRecordService.updateOrCreate(record);
      await loadReturnRecords(); // Reload the list after creating
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateReturnRecord(ReturnRecord record) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _returnRecordService.updateOrCreate(record);
      await loadReturnRecords(); // Reload the list after updating
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteReturnRecord(String id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _returnRecordService.delete(id);
      await loadReturnRecords(); // Reload the list after deleting
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
} 