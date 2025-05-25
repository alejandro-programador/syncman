import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/tipo_precio_model.dart';
import 'package:syncman_new/repositories/tipo_precio/tipo_precio_read_repository.dart';

class ApiTipoPrecioReadRepository extends TipoPrecioReadRepository {
  final ApiService _api;

  ApiTipoPrecioReadRepository(this._api);

  @override
  Future<List<TipoPrecio>> query({
    String? updatedAt,
    int? page,
  }) async {
    final response = await ApiService().getRequestNew('/tipo-precios', params: {
      'size': 500,
      'updatedAt': updatedAt,
      'page': page,
    });

    final data = response?.data;
    if (data == null || data.isEmpty) {
      return [];
    }

    return (data as List).map((tipoPrecio) {
      tipoPrecio['id'] = tipoPrecio['_id'];
      return TipoPrecio.fromMap(tipoPrecio);
    }).toList();
  }

  @override
  Future<TipoPrecio?> getById(String id) async {
    final response = await _api.getRequestNew('/tipo-precios/$id');
    final data = response?.data;

    if (data) {
      return TipoPrecio.fromMap(data);
    }

    return null;
  }

  @override
  Future<TipoPrecio?> getByCodigo(String codigo) async {
    final response = await _api.getRequestNew('/tipo-precios/codigo/$codigo');
    final data = response?.data;

    if (data) {
      return TipoPrecio.fromMap(data);
    }

    return null;
  }
} 