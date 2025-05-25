import 'package:flutter/material.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/services/sync/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService;
  // final LocalPaymentReadRepository _repository;
  List<Payment> _payments = [];
  bool _isLoading = false;
  String _searchQuery = '';

  // constructor / service
  // PaymentProvider() : _repository = LocalPaymentReadRepository(database.database);
  PaymentProvider(this._paymentService);

  List<Payment> get payments => _payments;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Payment> get filteredPayments {
    if (_searchQuery.isEmpty) {
      return _payments;
    }
    return _payments.where((payment) {
      final codigo = payment.codigo.toLowerCase();
      final descripcion = payment.descripcion.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return codigo.contains(query) || descripcion.contains(query);
    }).toList();
  }

  Future<void> loadPaymentsFromDatabase() async {
    _isLoading = true;
    notifyListeners();

    try {
      _payments = await _paymentService.query();
    } catch (e) {
      debugPrint('Error loading payments from database: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Payment service
  Future<void> updateOrCreate(Payment payment) async {
    await _paymentService.updateOrCreate(payment);
  }
} 