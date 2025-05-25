import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/repositories/ctaingeg/ctaingeg_read_repository.dart';
import 'package:syncman_new/repositories/ctaingeg/ctaingeg_write_repository.dart';

class CtaIngrEgrService {
  final CtaIngrEgrReadRepository _ctaIngrEgrReadRepository;
  final CtaIngrEgrWriteRepository _ctaIngrEgrWriteRepository;

  CtaIngrEgrService(this._ctaIngrEgrReadRepository, this._ctaIngrEgrWriteRepository);

  Future<List<CtaIngrEgr>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _ctaIngrEgrReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<CtaIngrEgr> getById(String id) async {
    final ctaIngrEgr = await _ctaIngrEgrReadRepository.getById(id);
    if (ctaIngrEgr == null) {
      throw Exception('CtaIngrEgr not found');
    }

    return ctaIngrEgr;
  }

  Future<CtaIngrEgr> getByCodigo(String codigo) async {
    final ctaIngrEgr = await _ctaIngrEgrReadRepository.getByCodigo(codigo);
    if (ctaIngrEgr == null) {
      throw Exception('CtaIngrEgr not found');
    }

    return ctaIngrEgr;
  }

  Future<void> updateOrCreate(CtaIngrEgr ctaIngrEgr) async {
    await _ctaIngrEgrWriteRepository.updateOrCreate(ctaIngrEgr);
  }
} 