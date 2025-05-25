import 'package:flutter/material.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/services/sync/collect_payment_method_service.dart';

class PaymentMethodProvider extends ChangeNotifier {
  List<CollectPaymentMethod> _paymentMethods = [];
  CollectPaymentMethod? _selectedPaymentMethod;
  final CollectPaymentMethodService _service;

  PaymentMethodProvider(this._service) {
    loadPaymentMethods();
  }

  List<CollectPaymentMethod> get paymentMethods => _paymentMethods;
  CollectPaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;

  Future<void> loadPaymentMethods() async {
    try {
      _paymentMethods = await _service.query();
      if (_paymentMethods.isNotEmpty && _selectedPaymentMethod == null) {
        _selectedPaymentMethod = _paymentMethods.first;
      }
      notifyListeners();
    } catch (e) {
      print('Error loading payment methods: $e');
    }
  }

  void setSelectedPaymentMethod(CollectPaymentMethod paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  // Text field controllers
  final TextEditingController _titularCuentaController = TextEditingController();
  final TextEditingController _titularRifController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _cobroController = TextEditingController();
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _ivaController = TextEditingController();
  final TextEditingController _depositoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Getters
  TextEditingController get titularCuentaController => _titularCuentaController;
  TextEditingController get titularRifController => _titularRifController;
  TextEditingController get referenciaController => _referenciaController;
  TextEditingController get fechaController => _fechaController;
  TextEditingController get cobroController => _cobroController;
  TextEditingController get baseController => _baseController;
  TextEditingController get ivaController => _ivaController;
  TextEditingController get depositoController => _depositoController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get amountController => _amountController;

  void clearAll() {
    _selectedPaymentMethod = null;
    _titularCuentaController.clear();
    _titularRifController.clear();
    _referenciaController.clear();
    _fechaController.clear();
    _cobroController.clear();
    _baseController.clear();
    _ivaController.clear();
    _depositoController.clear();
    _descriptionController.clear();
    _amountController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _titularCuentaController.dispose();
    _titularRifController.dispose();
    _referenciaController.dispose();
    _fechaController.dispose();
    _cobroController.dispose();
    _baseController.dispose();
    _ivaController.dispose();
    _depositoController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
} 