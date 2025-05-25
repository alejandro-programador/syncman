import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/repositories/ctaingeg/ctaingeg_read_repository.dart';

class ApiCtaIngrEgrReadRepository extends CtaIngrEgrReadRepository {
  final ApiService _api;

  ApiCtaIngrEgrReadRepository(this._api);

  @override
  Future<List<CtaIngrEgr>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/ctaingeg', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((ctaIngrEgr) {
      ctaIngrEgr['id'] = ctaIngrEgr['_id'];
      return CtaIngrEgr.fromJson(ctaIngrEgr);
    }).toList();
  }

  @override
  Future<CtaIngrEgr?> getById(String id) async {
    final response = await _api.getRequestNew('/ctaingeg/$id');
    final data = response?.data;

    if (data) {
      return CtaIngrEgr.fromJson(data);
    }

    return null;
  }

  @override
  Future<CtaIngrEgr?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/ctaingeg/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return CtaIngrEgr.fromJson(data);
    }

    return null;
  }
} 