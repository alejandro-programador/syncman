import 'package:syncman_new/models/ctaingeg_model.dart';

abstract class CtaIngrEgrReadRepository {
  Future<List<CtaIngrEgr>> query({
    String? updatedAt,
    int? page,
  });
  Future<CtaIngrEgr?> getById(String id);
  Future<CtaIngrEgr?> getByCodigo(String codigo);
} 