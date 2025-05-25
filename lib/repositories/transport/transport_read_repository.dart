import 'package:syncman_new/models/transport_model.dart';

abstract class TransportReadRepository {
  Future<List<Transport>> query({
    String? updatedAt,
    int? page,
  });
  Future<Transport?> getById(String id);
  Future<Transport?> getByCodigo(String codigo);
} 