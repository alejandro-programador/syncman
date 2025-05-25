import 'package:flutter/material.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/models/currency_model.dart';

class BillSelectionProvider with ChangeNotifier {
  List<Bill> _clientBills = [];
  List<String> _selectedFacturas = [];
  String? _selectedTipo;
  Currency? _selectedCurrency;
  final List<String> _tipos = ["Base", "IVA", "Base + IVA"];

  // Getters
  List<Bill> get clientBills => _clientBills;
  List<String> get selectedFacturas => _selectedFacturas;
  String? get selectedTipo => _selectedTipo;
  Currency? get selectedCurrency => _selectedCurrency;
  List<String> get tipos => _tipos;

  // Setters
  void setClientBills(List<Bill> bills) {
    _clientBills = bills;
    notifyListeners();
  }

  void setSelectedFacturas(List<String> facturas) {
    _selectedFacturas = facturas;
    notifyListeners();
  }

  void setSelectedTipo(String? tipo) {
    _selectedTipo = tipo;
    notifyListeners();
  }

  void setSelectedCurrency(Currency? currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  void clearSelection() {
    _selectedFacturas = [];
    _selectedTipo = null;
    _selectedCurrency = null;
    notifyListeners();
  }
} 