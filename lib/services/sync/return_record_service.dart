import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/repositories/return-record/return_record_read_repository.dart';
import 'package:syncman_new/repositories/return-record/return_record_write_repository.dart';

class ReturnRecordService {
  final ReturnRecordReadRepository _readRepository;
  final ReturnRecordWriteRepository _writeRepository;

  ReturnRecordService(this._readRepository, this._writeRepository);

  Future<List<ReturnRecord>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _readRepository.query(
      updatedAt: updatedAt,
      page: page,
    );
  }

  Future<ReturnRecord?> getById(String id) async {
    return await _readRepository.getById(id);
  }

  Future<ReturnRecord?> getByCodigo(String codigo) async {
    return await _readRepository.getByCodigo(codigo);
  }

  Future<void> updateOrCreate(ReturnRecord record) async {
    await _writeRepository.updateOrCreate(record);
  }

  Future<void> delete(String id) async {
    await _writeRepository.delete(id);
  }
} 