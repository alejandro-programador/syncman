import 'package:syncman_new/models/tax_model.dart';

abstract class TaxWriteRepository {
  Future<void> createTax(Tax tax);
  Future<void> updateTax(Tax tax);
  Future<void> deleteTax(String id);
} 