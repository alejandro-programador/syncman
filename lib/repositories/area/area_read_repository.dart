import 'package:syncman_new/models/zone_model.dart';

abstract class AreaReadRepository {
  Future<List<Area>> query({
    String? updatedAt,
    int? page,
  });

  Future<Area?> getById(String id);
} 