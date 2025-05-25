import '../../models/tipo_precio_model.dart';

abstract class TipoPrecioReadRepository {
  Future<List<TipoPrecio>> query({
    String? updatedAt,
    int? page,
  });
  Future<TipoPrecio?> getById(String id);
  Future<TipoPrecio?> getByCodigo(String codigo);
} 