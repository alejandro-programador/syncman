import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/services/sync/valija_service.dart';

class ValijaProvider with ChangeNotifier {
  final ValijaService _valijaService;
  List<Valija> _valijas = [];
  Map<String, dynamic> _valijaDetail = {};
  bool _isLoading = false;

  List<Valija> get valijas => _valijas;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get valijaDetail => _valijaDetail;

  ValijaProvider(this._valijaService);

  // Obtener datos desde la base local
  Future<void> loadValijas() async {
    _isLoading = true;
    notifyListeners();

    final valijasList = await _valijaService.query();
    _valijas = valijasList;

    _isLoading = false;
    notifyListeners();
  }
} 