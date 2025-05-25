import 'package:syncman_new/models/currency_model.dart';

abstract class CurrencyReadRepository {
  Future<List<Currency>> query({
    String? updatedAt,
    int? page,
  });
  Future<Currency?> getById(String id);
  Future<Currency?> getByCodigo(String codigo);
} 