import 'package:syncman_new/models/tipo_precio_model.dart';
import 'package:syncman_new/repositories/tipo_precio/tipo_precio_read_repository.dart';
import 'package:syncman_new/repositories/tipo_precio/tipo_precio_write_repository.dart';

class TipoPrecioService {
  final TipoPrecioReadRepository _tipoPrecioReadRepository;
  final TipoPrecioWriteRepository _tipoPrecioWriteRepository;

  TipoPrecioService(this._tipoPrecioReadRepository, this._tipoPrecioWriteRepository);

  Future<List<TipoPrecio>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _tipoPrecioReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<TipoPrecio> getById(String id) async {
    final tipoPrecio = await _tipoPrecioReadRepository.getById(id);
    if (tipoPrecio == null) {
      throw Exception('Tipo Precio not found');
    }

    return tipoPrecio;
  }

  Future<TipoPrecio> getByCodigo(String codigo) async {
    final tipoPrecio = await _tipoPrecioReadRepository.getByCodigo(codigo);
    if (tipoPrecio == null) {
      throw Exception('Tipo Precio not found');
    }

    return tipoPrecio;
  }

  Future<void> updateOrCreate(TipoPrecio tipoPrecio) async {
    await _tipoPrecioWriteRepository.updateOrCreate(tipoPrecio);
  }
} 