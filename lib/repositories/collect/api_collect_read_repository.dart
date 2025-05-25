import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/repositories/collect/collect_read_repository.dart';

class ApiCollectReadRepository extends CollectReadRepository {
  final ApiService _api;

  ApiCollectReadRepository(this._api);

  @override
  Future<List<Collect>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/solicitud-cobro', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((collect) {
      collect['id'] = collect['_id'];
      return Collect.fromMap(collect);
    }).toList();
  }

  @override
  Future<Collect?> getById(String id) async {
    final response = await _api.getRequestNew('/solicitud-cobro/$id');
    final data = response?.data;

    if (data) {
      return Collect.fromMap(data);
    }

    return null;
  }

  @override
  Future<Collect?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/solicitud-cobro/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Collect.fromMap(data);
    }

    return null;
  }
} 