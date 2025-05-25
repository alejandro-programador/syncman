import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/repositories/collect/collect_read_repository.dart';
import 'package:syncman_new/repositories/collect/collect_write_repository.dart';

class CollectService {
  final CollectReadRepository _collectReadRepository;
  final CollectWriteRepository _collectWriteRepository;

  CollectService(this._collectReadRepository, this._collectWriteRepository);

  Future<List<Collect>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _collectReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Collect> getById(String id) async {
    final collect = await _collectReadRepository.getById(id);
    if (collect == null) {
      throw Exception('Collect not found');
    }

    return collect;
  }

  Future<Collect> getByCodigo(String codigo) async {
    final collect = await _collectReadRepository.getByCodigo(codigo);
    if (collect == null) {
      throw Exception('Collect not found');
    }

    return collect;
  }

  Future<void> updateOrCreate(Collect collect) async {
    await _collectWriteRepository.updateOrCreate(collect);
  }
} 