import 'package:syncman_new/models/client_model.dart';

abstract class ClientReadRepository {
  Future<List<Client>> query({
    String? updatedAt,
    int? page,
  });
  Future<Client?> getById(String id);
  Future<Client?> getByCodigo(String codigo);
}
