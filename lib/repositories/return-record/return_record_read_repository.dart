import 'package:syncman_new/models/return_record_model.dart';

abstract class ReturnRecordReadRepository {
  Future<List<ReturnRecord>> query({
    String? updatedAt,
    int? page,
  });
  Future<ReturnRecord?> getById(String id);
  Future<ReturnRecord?> getByCodigo(String codigo);
} 