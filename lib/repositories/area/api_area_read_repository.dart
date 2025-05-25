import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/area/area_read_repository.dart';

class ApiAreaReadRepository extends AreaReadRepository {
  final ApiService _apiService;

  ApiAreaReadRepository(this._apiService);

  @override
  Future<List<Area>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/zonas', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((area) {
      area['id'] = area['_id'];
      return Area.fromMap(area);
    }).toList();
  }

  @override
  Future<Area?> getById(String id) async {
    final response = await _apiService.getRequestNew('/zonas/$id');
    final data = response?.data;

    if (data) {
      return Area.fromMap(data);
    }

    return null;
  }
}
