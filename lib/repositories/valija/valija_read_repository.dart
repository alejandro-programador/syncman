import 'package:syncman_new/models/valija_model.dart';

abstract class ValijaReadRepository {
  Future<List<Valija>> query({
    String? updatedAt,
    int? page,
  });
  Future<Valija?> getById(String id);
  Future<Valija?> getByCodigo(String codigo);
} 