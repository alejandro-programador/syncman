import 'package:syncman_new/models/collect_model.dart';

abstract class CollectReadRepository {
  Future<List<Collect>> query({
    String? updatedAt,
    int? page,
  });
  Future<Collect?> getById(String id);
  Future<Collect?> getByCodigo(String codigo);
} 