import 'package:flutter/material.dart';

class SelectedClientProvider extends ChangeNotifier {
  String? _clientId;
  String? _clientName;
  String? _clientPhone;
  String? _clientCompany;
  String? _clientCode;

  String? get clientId => _clientId;
  String? get clientName => _clientName;
  String? get clientPhone => _clientPhone;
  String? get clientCompany => _clientCompany;
  String? get clientCode => _clientCode;

  void setSelectedClient({
    required String clientId,
    required String clientName,
    required String clientPhone,
    required String clientCompany,
    required String clientCode,
  }) {
    _clientId = clientId;
    _clientName = clientName;
    _clientPhone = clientPhone;
    _clientCompany = clientCompany;
    _clientCode = clientCode;
    notifyListeners();
  }

  void clearSelectedClient() {
    _clientId = null;
    _clientName = null;
    _clientPhone = null;
    _clientCompany = null;
    _clientCode = null;
    notifyListeners();
  }
} 