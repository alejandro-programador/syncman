import 'package:syncman_new/models/tax_model.dart';

abstract class TaxReadRepository {
  Future<List<Tax>> getAllTaxes();
  Future<Tax?> getTaxById(String id);
  Future<List<Tax>> getTaxesByDate(String date);
} 