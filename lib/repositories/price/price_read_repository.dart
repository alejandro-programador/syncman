import 'package:syncman_new/models/price_model.dart';

abstract class PriceReadRepository {
  Future<List<Price>> query({
    String? updatedAt,
    int? page,
  });
  Future<Price?> getById(String id);
  Future<Price?> getByCodigo(String codigo);
} 