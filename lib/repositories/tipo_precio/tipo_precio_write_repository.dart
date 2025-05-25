import '../../models/tipo_precio_model.dart';

abstract class TipoPrecioWriteRepository {
  Future<void> save(TipoPrecio tipoPrecio);
  Future<void> updateOrCreate(TipoPrecio tipoPrecio);
} 