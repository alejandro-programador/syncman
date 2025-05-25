import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/services/sync/collect_service.dart';

class CollectsProvider with ChangeNotifier {
  final CollectService _collectService;
  List<Collect> _collects = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Collect> get collects => _collects;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  List<Collect> get filteredCollects {
    if (_searchQuery.isEmpty) {
      return _collects;
    }
    return _collects.where((collect) {
      final code = collect.codigo?.toLowerCase() ?? '';
      final description = collect.descripcion?.toLowerCase() ?? '';
      final searchLower = _searchQuery.toLowerCase();
      return code.contains(searchLower) || description.contains(searchLower);
    }).toList();
  }

  CollectsProvider(this._collectService);

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Obtener datos desde la base local
  Future<void> loadCollects() async {
    _isLoading = true;
    notifyListeners();

    final collectsList = await _collectService.query();
    _collects = collectsList;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCollectByID(String collectID) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getRequest('/cobros/$collectID');
      if (response != null && response.statusCode == 200) {
        // Handle response data
      } else {
        throw Exception('Error al obtener cobro. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener cobro: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
} 