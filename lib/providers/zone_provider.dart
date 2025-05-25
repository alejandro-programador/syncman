import 'package:flutter/material.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/services/sync/zone_service.dart';

class ZoneProvider extends ChangeNotifier {
  // final AppDatabase _database;
  final ZoneService _zoneService;
  List<Area> _zones = [];
  bool _isLoading = false;

  List<Area> get zones => _zones;
  bool get isLoading => _isLoading;

  ZoneProvider(this._zoneService);

  // Obtener datos desde la base local
  Future<void> loadZones() async {
    _isLoading = true;
    notifyListeners();

    final zoneList = await _zoneService.query();
    _zones = zoneList;

    _isLoading = false;
    notifyListeners();
  }

  //   try {
  //     final response = await ApiService().getRequest('/zonas');
  //     if (response != null && response.statusCode == 200) {
  //       _zones = List<Map<String, dynamic>>.from(response.data);
  //     }
  //   } catch (e) {
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
} 