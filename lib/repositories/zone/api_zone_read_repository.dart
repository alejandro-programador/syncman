import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/repositories/zone/zone_read_repository.dart';

class ApiZoneReadRepository extends ZoneReadRepository {
  final ApiService _apiService;

  ApiZoneReadRepository(this._apiService);

  @override
  Future<List<Area>> query({String? updatedAt, int? page}) async {
    final response = await _apiService.getRequestNew(
      '/areas',
      params: {
        if (updatedAt != null) 'updatedAt': updatedAt,
        if (page != null) 'page': page.toString(),
      },
    );

    if (response?.statusCode != 200) {
      throw Exception('Failed to load areas');
    }

    final List<dynamic> data = response?.data ?? [];
    return data.map((json) => Area.fromMap(json)).toList();
  }

  @override
  Future<Area?> getById(String id) async {
    final response = await _apiService.getRequestNew('/areas/$id');

    if (response?.statusCode != 200) {
      return null;
    }

    return Area.fromMap(response?.data);
  }

  @override
  Future<Area?> getByCodigo(String codigo) async {
    final response = await _apiService.getRequestNew(
      '/areas',
      params: {'codigo': codigo},
    );

    if (response?.statusCode != 200) {
      return null;
    }

    final List<dynamic> data = response?.data ?? [];
    if (data.isEmpty) {
      return null;
    }

    return Area.fromMap(data.first);
  }
} 