import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/repositories/valija/valija_read_repository.dart';

class ApiValijaReadRepository extends ValijaReadRepository {
  final ApiService _api;

  ApiValijaReadRepository(this._api);

  @override
  Future<List<Valija>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/valijas', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((valija) {
      valija['id'] = valija['_id'];
      return Valija.fromMap(valija);
    }).toList();
  }

  @override
  Future<Valija?> getById(String id) async {
    final response = await _api.getRequestNew('/valijas/$id');
    final data = response?.data;

    if (data) {
      return Valija.fromMap(data);
    }

    return null;
  }

  @override
  Future<Valija?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/valijas/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return Valija.fromMap(data);
    }

    return null;
  }
} 