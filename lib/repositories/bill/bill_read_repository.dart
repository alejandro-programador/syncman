import 'package:syncman_new/models/bill_model.dart';

abstract class BillReadRepository {
  Future<List<Bill>> query({
    String? updatedAt,
    int? page,
  });
  Future<Bill?> getById(String id);
  Future<Bill?> getByCodigo(String codigo);
  Future<List<Bill>> getByClientId(String clientId, {int page = 0, int pageSize = 20});
} 