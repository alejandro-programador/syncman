import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/zone/zone_read_repository.dart';
import 'package:syncman_new/repositories/zone/zone_write_repository.dart';

class ZoneService {
  final ZoneReadRepository _zoneReadRepository;
  final ZoneWriteRepository _zoneWriteRepository;

  ZoneService(this._zoneReadRepository, this._zoneWriteRepository);

  Future<List<Area>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _zoneReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Area> getById(String id) async {
    final area = await _zoneReadRepository.getById(id);
    if (area == null) {
      throw Exception('Area not found');
    }

    return area;
  }

  Future<Area> getByCodigo(String codigo) async {
    final area = await _zoneReadRepository.getByCodigo(codigo);
    if (area == null) {
      throw Exception('Area not found');
    }

    return area;
  }

  Future<void> updateOrCreate(Area area) async {
    await _zoneWriteRepository.updateOrCreate(area);
  }
} 