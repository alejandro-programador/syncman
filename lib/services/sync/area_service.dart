import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/area/area_read_repository.dart';
import 'package:syncman_new/repositories/area/area_write_repository.dart';

class AreaService {
  final AreaReadRepository _areaReadRepository;
  final AreaWriteRepository _areaWriteRepository;

  AreaService(this._areaReadRepository, this._areaWriteRepository);

  Future<List<Area>> query({
    String? updatedAt,
    int? page,
  }) async {
    final areas = await _areaReadRepository.query(
      updatedAt: updatedAt,
      page: page,
    );

    return areas;
  }

  Future<Area> getById(String id) async {
    final area = await _areaReadRepository.getById(id);
    if (area == null) {
      throw Exception('Area not found');
    }

    return area;
  }

  Future<void> updateOrCreate(Area area) async {
    await _areaWriteRepository.updateOrCreate(area);
  }
}
