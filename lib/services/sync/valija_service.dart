import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/repositories/valija/valija_read_repository.dart';
import 'package:syncman_new/repositories/valija/valija_write_repository.dart';

class ValijaService {
  final ValijaReadRepository _valijaReadRepository;
  final ValijaWriteRepository _valijaWriteRepository;

  ValijaService(this._valijaReadRepository, this._valijaWriteRepository);

  Future<List<Valija>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _valijaReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Valija> getById(String id) async {
    final valija = await _valijaReadRepository.getById(id);
    if (valija == null) {
      throw Exception('Valija not found');
    }

    return valija;
  }

  Future<Valija> getByCodigo(String codigo) async {
    final valija = await _valijaReadRepository.getByCodigo(codigo);
    if (valija == null) {
      throw Exception('Valija not found');
    }

    return valija;
  }

  Future<void> updateOrCreate(Valija valija) async {
    await _valijaWriteRepository.updateOrCreate(valija);
  }
} 