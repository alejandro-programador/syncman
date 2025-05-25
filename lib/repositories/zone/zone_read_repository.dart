import 'package:syncman_new/models/zone_model.dart';

abstract class ZoneReadRepository {
  Future<List<Area>> query({String? updatedAt, int? page});
  Future<Area?> getById(String id);
  Future<Area?> getByCodigo(String codigo);
} 