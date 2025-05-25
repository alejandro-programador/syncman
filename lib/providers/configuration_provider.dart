import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/services/sync/configuration_service.dart';
import 'package:syncman_new/utils/network_utils.dart';

class ConfigurationProvider with ChangeNotifier {
  final ConfigurationService _configurationService;
  late Configuration _configuration;
  bool _isLoading = false;

  Configuration get configuration => _configuration;
  bool get isLoading => _isLoading;

  ConfigurationProvider(this._configurationService);

  Future<void> fetchConfiguration() async {
    if (_isLoading) return; // Prevent multiple requests
    _isLoading = true;
    notifyListeners();

    Configuration userConfig = await _configurationService.get();
    await _configurationService.updateOrCreate(userConfig);

    await loadConfigurationFromDatabase();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadConfigurationFromDatabase() async {
    _isLoading = true;
    notifyListeners();

    _configuration = await _configurationService.get();

    _isLoading = false;
    notifyListeners();
  }
}
